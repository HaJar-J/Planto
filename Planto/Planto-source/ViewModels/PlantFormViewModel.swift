//  PlantFormViewModel.swift
//  Holds what the user is typing in the Set / Edit Reminder sheet.

import Foundation
import Observation

@MainActor
@Observable
final class PlantFormViewModel {
    var name: String
    var room: Room
    var light: LightCondition
    var frequency: WateringFrequency
    var waterAmount: WaterAmount

    /// Optional: `nil` = adding a new plant, a value = editing that plant.
    private let editingPlant: Plant?

    init(plant: Plant? = nil) {
        editingPlant = plant
        name = plant?.name ?? ""
        room = plant?.room ?? .bedroom
        light = plant?.light ?? .fullSun
        frequency = plant?.frequency ?? .everyDay
        waterAmount = plant?.waterAmount ?? .small
    }

    var isEditing: Bool {
        editingPlant != nil
    }

    /// Save is only allowed when the name isn't empty.
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Builds the final Plant from the form fields.
    func makePlant() -> Plant {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        if var plant = editingPlant {
            plant.name = cleanName
            plant.room = room
            plant.light = light
            plant.frequency = frequency
            plant.waterAmount = waterAmount
            return plant
        }
        return Plant(
            name: cleanName,
            room: room,
            light: light,
            frequency: frequency,
            waterAmount: waterAmount
        )
    }
}
