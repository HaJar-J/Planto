import SwiftUI

struct EmptyStateView: View {
    var mood: PlantIconView.Mood?   // Optional: nil = text only
    let title: String
    var message: String?

    var body: some View {
        VStack(spacing: 12) {
            if let mood {
                PlantIconView(mood: mood, height: 150)
            }

            Text(title)
                .font(mood == nil ? .subheadline : .headline)
                .foregroundStyle(mood == nil ? Color.secondary : Color.primary)

            if let message {
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview("All done") {
    EmptyStateView(mood: .winking, title: "All Done! 🎉", message: "All Reminders Completed")
        .preferredColorScheme(.dark)
}

#Preview("Empty") {
    EmptyStateView(title: "No reminders set yet...")
        .preferredColorScheme(.dark)
}
