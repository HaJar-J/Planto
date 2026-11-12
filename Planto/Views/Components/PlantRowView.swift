//  PlantRowView.swift
//  One row in the list: checkbox, room, name and the two chips.

import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    let isCompleted: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isCompleted ? Color.plantGreen : Color.secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isCompleted ? "Mark as not watered" : "Mark as watered")

            VStack(alignment: .leading, spacing: 6) {
                Label("in \(plant.room.rawValue)", systemImage: "location")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(plant.name)
                    .font(.title3)
                    .foregroundStyle(isCompleted ? Color.secondary : Color.primary)

                HStack(spacing: 8) {
                    InfoChipView(systemImage: plant.light.symbolName, text: plant.light.rawValue)
                    InfoChipView(systemImage: "drop", text: plant.waterAmount.rawValue)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    VStack {
        PlantRowView(plant: Plant.samples[0], isCompleted: false, onToggle: {})
        PlantRowView(plant: Plant.samples[1], isCompleted: true, onToggle: {})
    }
    .padding()
}
