//  PlantIconView.swift
//  The app's plant illustration, reused on every screen.

import SwiftUI

struct PlantIconView: View {
    /// Which version of the illustration to show.
    enum Mood: String {
        case happy = "PlantHappy"     // open eyes, smile
        case winking = "PlantWink"    // used for "All Done"
    }

    var mood: Mood = .happy
    var height: CGFloat = 160

    var body: some View {
        Image(mood.rawValue)
            .resizable()
            .scaledToFit()
            .frame(height: height)
            .accessibilityHidden(true)   // decorative
    }
}

#Preview {
    HStack {
        PlantIconView(mood: .happy, height: 120)
        PlantIconView(mood: .winking, height: 120)
    }
    .padding()
}
