//  FloatingAddButton.swift
//  The round green "+" button. Uses Liquid Glass.

import SwiftUI

struct FloatingAddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .frame(width: 28, height: 28)
        }
        .buttonStyle(.glassProminent)
        .buttonBorderShape(.circle)
        .controlSize(.large)
        .tint(Color.buttonGreen)
        .accessibilityLabel("Add plant reminder")
    }
}

#Preview {
    FloatingAddButton(action: {})
        .padding()
}
