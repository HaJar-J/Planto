import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 12) {
                PlantIconView(mood: .happy, height: 150)
                Text("Planto")
                    .font(.largeTitle.bold())
            }
        }
    }
}

#Preview {
    SplashView()
}
