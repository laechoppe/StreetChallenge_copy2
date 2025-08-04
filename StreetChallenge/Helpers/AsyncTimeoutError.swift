//
//  AsyncTimeoutError.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 22/06/2025.
//

import Foundation

enum AsyncTimeoutError: LocalizedError {
    case timeout(seconds: TimeInterval)

    var errorDescription: String? {
        switch self {
        case .timeout(let seconds):
            return "Operation timed out after \(seconds) seconds"
        }
    }
}

struct AsyncTimeoutHelper {

    /// Execute an async operation with a timeout
    /// - Parameters:
    ///   - seconds: Timeout duration in seconds
    ///   - operation: The async operation to execute
    /// - Returns: The result of the operation
    /// - Throws: Either the operation's error or AsyncTimeoutError.timeout
    static func withTimeout<T: Sendable>(
        seconds: TimeInterval,
        operation: @escaping @Sendable () async throws -> T
    ) async throws -> T {

        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }

            group.addTask {
                try await Task.sleep(for: .seconds(seconds))
                throw AsyncTimeoutError.timeout(seconds: seconds)
            }

            defer { group.cancelAll() }

            guard let result = try await group.next() else {
                throw AsyncTimeoutError.timeout(seconds: seconds)
            }

            return result
        }
    }

    /// Execute an async operation with a timeout, returning nil on timeout instead of throwing
    /// - Parameters:
    ///   - seconds: Timeout duration in seconds
    ///   - operation: The async operation to execute
    /// - Returns: The result of the operation or nil if timeout
    static func withTimeoutOrNil<T: Sendable>(
        seconds: TimeInterval,
        operation: @escaping @Sendable () async throws -> T
    ) async -> T? {
        do {
            return try await withTimeout(seconds: seconds, operation: operation)
        } catch {
            return nil
        }
    }
}
