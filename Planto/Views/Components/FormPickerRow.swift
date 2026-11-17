//  FormPickerRow.swift
//  One form row: icon + label on the left, a menu picker on the right.
//  Generic, so it works with any of our enums (Room, LightCondition, ...).

import SwiftUI

struct FormPickerRow<Value: CaseIterable & Hashable & RawRepresentable>: View
    where Value.RawValue == String {

    let title: String
    let systemImage: String
    @Binding var selection: Value

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(Array(Value.allCases), id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .tint(Color.valueGray)
        }
        .font(.body)
        .padding(.horizontal, 19)
        .frame(height: 47)
    }
}

#Preview {
    @Previewable @State var room = Room.bedroom
    FormPickerRow(title: "Room", systemImage: "location", selection: $room)
        .background(Color.cardBackground)
        .padding()
        .preferredColorScheme(.dark)
}
