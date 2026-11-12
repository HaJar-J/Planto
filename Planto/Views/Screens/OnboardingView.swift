import SwiftUI

struct OnboardingView: View {
    let viewModel: PlantListViewModel
    let onFinish: () -> Void

    @State private var showForm = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                PlantIconView(mood: .happy, height: 190)

                Text("Start your plant journey!")
                    .font(.title3.bold())

                Text("Now all your plants will be in one place and we will help you take care of them :)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                Button("Set Plant Reminder") {
                    showForm = true
                }
                .buttonStyle(.glassProminent)
                .controlSize(.large)
                .tint(Color.buttonGreen)
                .padding(.bottom, 24)
            }
        }
        .sheet(isPresented: $showForm) {
            PlantFormView(onSave: { plant in
                viewModel.add(plant)
                onFinish()
            })
        }
    }
}

#Preview {
    OnboardingView(
        viewModel: PlantListViewModel(storage: PlantStorage(fileName: "preview.json"), plants: []),
        onFinish: {}
    )
}
