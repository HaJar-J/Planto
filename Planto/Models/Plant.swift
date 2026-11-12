//  Plant.swift
//  One plant reminder. A struct = simple data that is copied, not shared.

import Foundation

struct Plant: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var room: Room
    var light: LightCondition
    var frequency: WateringFrequency
    var waterAmount: WaterAmount

    /// Optional: `nil` means this plant has never been watered.
    var lastWateredDate: Date?

    // MARK: - Schedule logic (pure data rules, no UI)

    /// True if the plant was marked as watered today.
    func isWateredToday(calendar: Calendar = .current) -> Bool {
        guard let lastWateredDate else { return false }
        return calendar.isDateInToday(lastWateredDate)
    }

    /// True if the plant belongs in today's list:
    /// never watered, watered today (so it stays checked), or its interval has passed.
    func isScheduledForToday(calendar: Calendar = .current) -> Bool {
        guard let lastWateredDate else { return true }
        if calendar.isDateInToday(lastWateredDate) { return true }

        let lastDay = calendar.startOfDay(for: lastWateredDate)
        let today = calendar.startOfDay(for: Date())
        let daysPassed = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
        return daysPassed >= frequency.intervalInDays
    }
}

// MARK: - Sample data (used by previews only)

extension Plant {
    static let samples: [Plant] = [
        Plant(name: "Monstera", room: .kitchen, light: .fullSun, frequency: .everyDay, waterAmount: .small),
        Plant(name: "Pothos", room: .bedroom, light: .partialSun, frequency: .every3Days, waterAmount: .medium),
        Plant(name: "Orchid", room: .livingRoom, light: .lowLight, frequency: .onceAWeek, waterAmount: .small),
        Plant(name: "Spider", room: .kitchen, light: .fullSun, frequency: .everyDay, waterAmount: .large)
    ]
}
