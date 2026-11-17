//  SheetHeaderView.swift
//  Top bar of the sheet: X cancel, title, checkmark confirm.
//  Both buttons are 44 x 44 pt Liquid Glass circles.

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
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive(), in: .circle)
            .accessibilityLabel("Cancel")

            Spacer()

            Text(title)
                .font(.headline)

            Spacer()

            Button(action: onConfirm) {
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.tint(Color.buttonGreen).interactive(), in: .circle)
            .disabled(!canConfirm)
            .opacity(canConfirm ? 1 : 0.4)
            .accessibilityLabel("Save")
        }
    }
}

#Preview {
    SheetHeaderView(title: "Set Reminder", canConfirm: true, onCancel: {}, onConfirm: {})
        .padding(.horizontal, 27)
        .padding(.top, 15)
        .background(Color.sheetBackground)
        .preferredColorScheme(.dark)
}
