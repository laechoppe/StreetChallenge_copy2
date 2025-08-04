
import SwiftUI
import MapKit

struct AreaGuideDetailsView: View {
    @Environment(PointsOfInterestViewModel.self) private var pointsOfInterestViewModel: PointsOfInterestViewModel
    @Environment(LocationHelper.self) private var locationHelper: LocationHelper
    @Environment(\.dismiss) var dismiss

    @State private var cameraPosition: MapCameraPosition
    @State private var navigateToFullPoiView = false
    @State private var currentSelection: PointOfInterest?
    @State private var selectedMarkerID: String? = nil

    @State private var cachedPointsOfInterest: [PointOfInterest] = []
    @State private var cachedCoordinates: [(id: String, coordinate: CLLocationCoordinate2D)] = []
    @State private var cachedLineCoordinates: [CLLocationCoordinate2D] = []

    var area: Area

    private let regionOffset: Double = 0.002
    private let defaultDelta: Double = 0.005

    private var bottomCardHeight: CGFloat {
        UIScreen.main.bounds.height / (UIScreen.main.bounds.width <= 375 ? 2 : 2.5)
    }

    init(
        area: Area
    ) {
        let delta = defaultDelta
        self.area = area
        self._cameraPosition = State(initialValue: .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: area.center.latitude,
                longitude: area.center.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: delta,
                longitudeDelta: delta
            )
        )))
    }

    var body: some View {
        GeometryReader { geometry in

            ZStack(alignment: .top) {
                ZStack(alignment: .bottom) {
                    Map(
                        position: $cameraPosition,
                        interactionModes: .all,
                        selection: $selectedMarkerID
                    ) {
                        ForEach(cachedCoordinates, id: \.id) { entry in
                            Marker(entry.id, coordinate: entry.coordinate)
                                .tag(entry.id)
                                .tint(Color.blue)
                        }

                        if cachedLineCoordinates.count >= 2 {
                            MapPolyline(coordinates: cachedLineCoordinates)
                                .stroke(Color.blue, lineWidth: 3)
                        }
                    }
                    .mapControls {
                        if locationHelper.locationPermissionGranted {
                            MapUserLocationButton()
                                .buttonBorderShape(.circle)
                        }
                        MapCompass()
                    }
                    self.bottomCard(geometry: geometry)
                        .frame(height: bottomCardHeight)
                }

                VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            BackButtonView()
                        }
                        Spacer()
                    }
                    .padding(.top, 6)
                    .padding(.horizontal, 4)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: [.bottom])
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToFullPoiView) {
                if let currentSelection {
                    PoiFullView(poi: currentSelection, area: area)
                }
            }
            .onAppear {
                if cachedPointsOfInterest.isEmpty {
                    updateCachedData()
                }
                if currentSelection == nil, let firstPoi = cachedPointsOfInterest.first {
                    currentSelection = firstPoi // Ensure a valid initial selection
                }
            }
            .onChange(of: currentSelection) {
                updateRegion(for: currentSelection)
            }
            .onChange(of: selectedMarkerID) {
                currentSelection = cachedPointsOfInterest.first(where: { $0.id == selectedMarkerID })
            }
            .onChange(of: pointsOfInterestViewModel.pointsOfInterest) {
                updateCachedData()
            }
        }
    }

    @ViewBuilder
    private func bottomCard(geometry: GeometryProxy) -> some View {
        ZStack(alignment: .top) {
            VStack {
                pointIndicators(geometry: geometry)
                    .padding(.top)
                cardHeader()
                pointDetailsTabView()
                MainButton(title: "See more") {
                    navigateToFullPoiView = true
                }
                .padding(.bottom, 40)
                Spacer()
            }
        }
        .background(Color.mainWhite, in: RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func pointIndicators(geometry: GeometryProxy) -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    ForEach(cachedPointsOfInterest, id: \.id) { poi in
                        Circle()
                            .fill(currentSelection == poi ? Color.blue : Color.gray.opacity(0.6))
                            .frame(width: 10, height: 10)
                            .id(poi.id)
                    }
                }
                .frame(minWidth: geometry.size.width, alignment: .center)
                .padding(.horizontal)
            }
            .scrollIndicators(.never)
            .onChange(of: currentSelection) {
                if let newId = currentSelection?.id {
                    withAnimation {
                        proxy.scrollTo(newId, anchor: .center)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func cardHeader() -> some View {
        let currentSelectionId = currentSelection?.id ?? ""
        HStack {
            Text("Point \(currentSelectionId)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    private func pointDetailsTabView() -> some View {
        TabView(selection: $currentSelection) {
            ForEach(cachedPointsOfInterest, id: \.id) { poi in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(poi.title)
                            .font(.title)
                        Text(poi.shortDescription)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .defaultScrollAnchor(.top, for: .initialOffset)
                .tag(poi)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    private func updateRegion(for poi: PointOfInterest?) {
        guard let poi,
              let lat = poi.coordinate?.latitude,
              let lon = poi.coordinate?.longitude else { return }
        withAnimation {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: lat - regionOffset, longitude: lon),
                    span: MKCoordinateSpan(latitudeDelta: defaultDelta, longitudeDelta: defaultDelta)
                ))
            selectedMarkerID = poi.id
        }
    }

    private func filterPointsOfInterest() -> [PointOfInterest] {
        pointsOfInterestViewModel.pointsOfInterest
            .filter { $0.areaId == area.id }
            .sorted { $0.id < $1.id }
    }

    private func mapToCoordinates(
        points: [PointOfInterest]
    ) -> [(id: String, coordinate: CLLocationCoordinate2D)] {
        points.compactMap { poi in
            guard let lat = poi.coordinate?.latitude,
                  let lon = poi.coordinate?.longitude else { return nil }
            return (id: poi.id, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
    }

    private func mapToLineCoordinates(
        points: [(id: String, coordinate: CLLocationCoordinate2D)]
    ) -> [CLLocationCoordinate2D] {
        points.map { $0.coordinate }
    }

    private func updateCachedData() {
        cachedPointsOfInterest = filterPointsOfInterest()
        cachedCoordinates = mapToCoordinates(points: cachedPointsOfInterest)
        cachedLineCoordinates = mapToLineCoordinates(points: cachedCoordinates)
    }
}

#Preview {
    let pointsOfInterestViewModel: PointsOfInterestViewModel = {
        let viewModel = PointsOfInterestViewModel()
        viewModel.pointsOfInterest = [mockPoi1, mockPoi2, mockPoi3, mockPoi4]
        return viewModel
    }()

    let locationHelper: LocationHelper = .init()

    return AreaGuideDetailsView(area: mockArea)
        .environment(pointsOfInterestViewModel)
        .environment(locationHelper)
}
