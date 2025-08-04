//
//  AreasViewModelTests.swift
//  StreetChallenge
//
//  Created by Uladzislau on 01/08/2025.
//

import XCTest
import Foundation
@testable import StreetChallenge

@MainActor
class AreasViewModelTests: XCTestCase {
    
    var viewModel: AreasViewModel!
    var mockDataService: MockAreasDataService!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockAreasDataService()
        viewModel = AreasViewModel(dataService: mockDataService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func testInit_SetsInitialState() {
        XCTAssertTrue(viewModel.areas.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchData_Success_LoadsAreasAndFiltersTestAreas() async {
        let testAreas = [
            mockArea, mockArea2
        ]
        mockDataService.areasToReturn = testAreas
        
        await viewModel.fetchData()
        
        XCTAssertEqual(viewModel.areas.count, 2)
        XCTAssertEqual(viewModel.areas[0].name, mockArea.name)
        XCTAssertEqual(viewModel.areas[1].name, mockArea2.name)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchData_SetsLoadingState() async {
        mockDataService.shouldDelay = true
        
        let fetchTask = Task {
            await viewModel.fetchData()
        }
        
        try? await Task.sleep(nanoseconds: 10_000_000)
        XCTAssertTrue(viewModel.isLoading)
        
        mockDataService.shouldDelay = false
        await fetchTask.value
    }
    
    func testFetchData_ErrorThenSuccess_RecoversOnRetry() async {
        mockDataService.shouldThrowError = true
        mockDataService.failCallsCount = 2
        mockDataService.areasToReturn = [mockArea]
        
        await viewModel.fetchData()
        
        XCTAssertEqual(mockDataService.fetchCallCount, 3)
        XCTAssertEqual(viewModel.areas.count, 1)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    
    func testFetchData_WithAllTestAreas_ReturnsEmptyArray() async {
        let testAreas: [Area] = []
        mockDataService.areasToReturn = testAreas
        
        await viewModel.fetchData()
        
        XCTAssertTrue(viewModel.areas.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
}

// MARK: - Mock Data Service

final class MockAreasDataService: AreasDataFetching, @unchecked Sendable {
    var areasToReturn: [Area] = []
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "MockError", code: 500)
    var fetchCallCount = 0
    var shouldDelay = false
    var failCallsCount = 0
    
    func fetchAreas() async throws -> [Area] {
        fetchCallCount += 1
        
        if shouldDelay {
            try await Task.sleep(nanoseconds: 100_000_000)
        }
        
        if shouldThrowError && fetchCallCount <= failCallsCount {
            throw errorToThrow
        }
        
        return areasToReturn
    }
}
