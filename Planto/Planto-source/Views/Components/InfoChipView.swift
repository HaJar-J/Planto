//  InfoChipView.swift
//  The small pill under a plant name ("Full sun", "20-50 ml").

import SwiftUI

struct InfoChipView: View {
    let systemImage: String
    let text: String

    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.chipBackground, in: Capsule())
    }
}

#Preview {
    InfoChipView(systemImage: "drop", text: "20-50 ml")
        .padding()
}
