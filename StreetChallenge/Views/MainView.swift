import SwiftUI

struct MainView: View {
    @Environment(QuestionsViewModel.self) private var questionsViewModel: QuestionsViewModel
    @Environment(AreasViewModel.self) private var areasViewModel: AreasViewModel
    @Environment(PointsOfInterestViewModel.self) private var pointsOfInterestViewModel: PointsOfInterestViewModel
    @Environment(UserViewModel.self) private var userModel: UserViewModel
    @State var paywallPresented = false
    @State private var selectedArea: Area?
    @State private var navigateToQuestions = false
    @State private var currentIndex: Int?
    @State private var guideMode: Bool
    @State private var selectedOption: MenuOption

    init(guideMode: Bool = false) {
        self._guideMode = State(initialValue: guideMode)
        self._selectedOption = State(initialValue: guideMode ? .walkingTours : .treasureHunts)
    }

    var body: some View {
        let areas = selectedOption == .walkingTours ? areasViewModel.areas.filter { $0.hasGuides } : areasViewModel.areas

        GeometryReader { geometry in
            VStack(alignment: .center) {
                TopMenuView(selectedOption: $selectedOption, currentIndex: $currentIndex)

                AreaScrollView(
                    areas: areas,
                    geometry: geometry,
                    selectedArea: $selectedArea,
                    navigateToQuestions: $navigateToQuestions,
                    paywallPresented: $paywallPresented,
                    userModel: userModel,
                    selectedOption: selectedOption
                )
            }
            .onAppear {
                currentIndex = 0
                Task {
                    await questionsViewModel.fetchData()
                    await pointsOfInterestViewModel.fetchData()
                }
            }
            .sheet(isPresented: $paywallPresented, onDismiss: {
                if userModel.subscriptionActive { navigateToQuestions = true }
            }) {
                PaywallView(isPresented: $paywallPresented)
            }
            .navigationDestination(isPresented: $navigateToQuestions) {
                if let selectedArea {
                    NavigationDestinationView(selectedArea: selectedArea, selectedOption: selectedOption, paywallPresented: $paywallPresented)
                }
            }
        }
    }
}


#Preview {
    let mockAreasViewModel = AreasViewModel()
    mockAreasViewModel.areas = [mockArea, mockArea2, mockArea3]

    let mockQuestionsViewModel = QuestionsViewModel()
    mockQuestionsViewModel.questions = [mockQuestion, mockQuestion2]

    return MainView(guideMode: false)
        .environment(mockAreasViewModel)
        .environment(mockQuestionsViewModel)
        .environment(UserViewModel.shared)
        .environment(ImageLoader())
}
