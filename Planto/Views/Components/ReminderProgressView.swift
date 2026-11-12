//  ReminderProgressView.swift
//  Custom animated progress bar with its message.

import SwiftUI

struct ReminderProgressView: View {
    let progress: Double
    let message: String

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {
        VStack(spacing: 10) {
            Text(message)
                .font(.subheadline)

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.chipBackground)
                    Capsule()
                        .fill(Color.plantGreen)
                        .frame(width: proxy.size.width * clampedProgress)
                }
            }
            .frame(height: 6)
        }
        .animation(.spring(duration: 0.4), value: clampedProgress)
    }
}

#Preview {
    ReminderProgressView(progress: 0.5, message: "2 of your plants feel loved today ✨")
        .padding()
}
