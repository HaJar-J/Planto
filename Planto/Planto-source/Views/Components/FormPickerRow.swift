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
        HStack {
            Label(title, systemImage: systemImage)
                .font(.subheadline)
            Spacer()
            Picker(title, selection: $selection) {
                ForEach(Array(Value.allCases), id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .tint(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    @Previewable @State var room = Room.bedroom
    FormPickerRow(title: "Room", systemImage: "location", selection: $room)
        .padding()
}
