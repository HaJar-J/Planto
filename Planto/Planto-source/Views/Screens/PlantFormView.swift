//  PlantFormView.swift
//  The Set Reminder / Edit Reminder sheet (one screen, two modes).

import SwiftUI

struct PlantFormView: View {
    @State private var viewModel: PlantFormViewModel
    @Environment(\.dismiss) private var dismiss

    let onSave: (Plant) -> Void
    let onDelete: (() -> Void)?

    init(
        plant: Plant? = nil,
        onSave: @escaping (Plant) -> Void,
        onDelete: (() -> Void)? = nil
    ) {
        _viewModel = State(initialValue: PlantFormViewModel(plant: plant))
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        VStack(spacing: 20) {
            SheetHeaderView(
                title: "Set Reminder",
                canConfirm: viewModel.canSave,
                onCancel: { dismiss() },
                onConfirm: {
                    onSave(viewModel.makePlant())
                    dismiss()
                }
            )

            ScrollView {
                VStack(spacing: 16) {
                    nameField

                    card {
                        FormPickerRow(title: "Room", systemImage: "location", selection: $viewModel.room)
                        Divider()
                        FormPickerRow(title: "Light", systemImage: "sun.max", selection: $viewModel.light)
                    }

                    card {
                        FormPickerRow(title: "Watering Days", systemImage: "drop", selection: $viewModel.frequency)
                        Divider()
                        FormPickerRow(title: "Water", systemImage: "drop", selection: $viewModel.waterAmount)
                    }

                    if viewModel.isEditing, let onDelete {
                        Button("Delete Reminder", role: .destructive) {
                            onDelete()
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cardBackground, in: RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
        .padding()
        .background(Color.appBackground.ignoresSafeArea())
    }

    private var nameField: some View {
        HStack {
            Text("Plant Name")
                .font(.subheadline)
            TextField("Pothos", text: $viewModel.name)
        }
        .padding()
        .background(Color.cardBackground, in: RoundedRectangle(cornerRadius: 20))
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 4) {
            content()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.cardBackground, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview("Add") {
    PlantFormView(onSave: { _ in })
}

#Preview("Edit") {
    PlantFormView(plant: Plant.samples[0], onSave: { _ in }, onDelete: {})
}
