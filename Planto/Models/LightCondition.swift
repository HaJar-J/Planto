//  LightCondition.swift
//  How much light a plant gets, plus the SF Symbol shown next to it.

import Foundation

enum LightCondition: String, CaseIterable, Identifiable, Codable {
    case fullSun = "Full sun"
    case partialSun = "Partial sun"
    case lowLight = "Low light"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .fullSun: "sun.max"
        case .partialSun: "cloud.sun"
        case .lowLight: "moon"
        }
    }
}
