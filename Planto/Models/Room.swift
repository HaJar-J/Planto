//
//  Room.swift
//  Planto
//
//  Created by Hajar Mudhi  on 29/05/1448 AH.
//

import Foundation
enum Room: String, CaseIterable, Identifiable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"

    var id: String { rawValue }

}
  


