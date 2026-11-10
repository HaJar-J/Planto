//  Room.swift
//  The rooms a plant can live in (fixed list = enum).

import Foundation

enum Room: String, CaseIterable, Identifiable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"

    var id: String { rawValue }
}
