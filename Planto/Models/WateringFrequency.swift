//  WateringFrequency.swift
//  How often a plant needs water. `intervalInDays` drives the schedule logic.

import Foundation

enum WateringFrequency: String, CaseIterable, Identifiable, Codable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"

    var id: String { rawValue }

    var intervalInDays: Int {
        switch self {
        case .everyDay: 1
        case .every2Days: 2
        case .every3Days: 3
        case .onceAWeek: 7
        case .every10Days: 10
        case .every2Weeks: 14
        }
    }
}
