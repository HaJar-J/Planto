//  Color+Theme.swift
//  App colors defined once. Each one has a light AND a dark value,
//  so the whole app follows the system appearance automatically.

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

extension Color {
    /// A color that switches between two hex values with light/dark mode.
    init(lightHex: UInt32, darkHex: UInt32) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor { traits in
            let hex = traits.userInterfaceStyle == .dark ? darkHex : lightHex
            return UIColor(
                red: CGFloat((hex >> 16) & 0xFF) / 255,
                green: CGFloat((hex >> 8) & 0xFF) / 255,
                blue: CGFloat(hex & 0xFF) / 255,
                alpha: 1
            )
        })
        #else
        self.init(
            red: Double((darkHex >> 16) & 0xFF) / 255,
            green: Double((darkHex >> 8) & 0xFF) / 255,
            blue: Double(darkHex & 0xFF) / 255
        )
        #endif
    }

    static let appBackground = Color(lightHex: 0xF2F2F7, darkHex: 0x000000)
    static let cardBackground = Color(lightHex: 0xFFFFFF, darkHex: 0x1C1C1E)
    static let chipBackground = Color(lightHex: 0xE5E9EE, darkHex: 0x25303B)
    static let plantGreen = Color(lightHex: 0x2E8B6A, darkHex: 0x5DD3A4)
    static let buttonGreen = Color(lightHex: 0x2E7D5B, darkHex: 0x3E7D63)
}
