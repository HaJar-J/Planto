//  SheetHeaderView.swift
//  Top bar of the sheet: ✕ cancel, title, ✓ confirm (Liquid Glass buttons).

import SwiftUI

struct SheetHeaderView: View {
    let title: String
    let canConfirm: Bool
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        HStack {
            Button(action: onCancel) {
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.glass)
            .buttonBorderShape(.circle)
            .accessibilityLabel("Cancel")

            Spacer()
            Text(title)
                .font(.headline)
            Spacer()

            Button(action: onConfirm) {
                Image(systemName: "checkmark")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.circle)
            .tint(Color.buttonGreen)
            .disabled(!canConfirm)
            .accessibilityLabel("Save")
        }
    }
}

#Preview {
    SheetHeaderView(title: "Set Reminder", canConfirm: true, onCancel: {}, onConfirm: {})
        .padding()
}
