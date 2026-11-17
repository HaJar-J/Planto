//  FloatingAddButton.swift
//  The round green "+" button: exactly 44 x 44 pt, with Liquid Glass.

import SwiftUI

struct FloatingAddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(Color.buttonGreen).interactive(), in: .circle)
        .accessibilityLabel("Add plant reminder")
    }
}

#Preview {
    FloatingAddButton(action: {})
        .padding()
        .preferredColorScheme(.dark)
}
