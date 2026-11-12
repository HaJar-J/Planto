//  RootView.swift
//  Decides what to show: splash -> onboarding (new user) or main screen.
//  Owns the single PlantListViewModel and shares it with the screens.

import SwiftUI

struct RootView: View {
    @State private var viewModel = PlantListViewModel()
    @State private var showSplash = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

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
            try? await Task.sleep(for: .seconds(1.5))
            showSplash = false
        }
    }
}

#Preview {
    RootView()
}
