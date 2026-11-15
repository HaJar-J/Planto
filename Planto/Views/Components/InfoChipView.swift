//  InfoChipView.swift
//  The small pill under a plant name ("Full sun", "20-50 ml").

import SwiftUI

struct InfoChipView: View {
    let systemImage: String
    let text: String
    var tint: Color = .secondary

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: systemImage)
            Text(text)
        }
        .font(.caption2)
        .foregroundStyle(tint)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(tint.opacity(0.15), in: Capsule())
    }
}

#Preview {
    HStack {
        InfoChipView(systemImage: "sun.max", text: "Full sun", tint: Color.sunYellow)
        InfoChipView(systemImage: "drop", text: "20-50 ml", tint: Color.waterBlue)
    }
    .padding()
    .preferredColorScheme(.dark)
}
