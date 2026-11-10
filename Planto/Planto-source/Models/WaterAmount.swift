//  WaterAmount.swift
//  How much water a plant needs each time.

import Foundation

enum WaterAmount: String, CaseIterable, Identifiable, Codable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"

    var id: String { rawValue }
}
