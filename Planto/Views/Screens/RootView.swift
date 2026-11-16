
import SwiftUI

struct RootView: View {
    
    @State private var viewModel = PlantListViewModel()
    @State private var showSplash = true
    
    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                
            } else if hasCompletedOnboarding || !viewModel.plants.isEmpty {
                MyPlantsView(viewModel: viewModel)
                
            } else {
                OnboardingView(viewModel: viewModel) {
                    hasCompletedOnboarding = true
                }
            }
        }
        .animation(.easeInOut, value: showSplash)
        
        
        
        .task {
            await NotificationManager.shared.clearBadge()
            
            try? await Task.sleep(for: .seconds(1.5))
            showSplash = false
            
        
        }
        
    }
    
    struct RootView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
}
