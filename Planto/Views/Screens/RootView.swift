
import SwiftUI

struct RootView: View {

    @State private var viewModel = PlantListViewModel()

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    var body: some View {

        Group {
            if hasCompletedOnboarding || !viewModel.plants.isEmpty {

                MyPlantsView(viewModel: viewModel)

            } else {

                OnboardingView(viewModel: viewModel) {
                    hasCompletedOnboarding = true
                }
            }
        }
        .task {
            await NotificationManager.shared.clearBadge()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
