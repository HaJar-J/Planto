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
        VStack(spacing: 0) {
            SheetHeaderView(
                title: "Set Reminder",
                canConfirm: viewModel.canSave,
                onCancel: { dismiss() },
                onConfirm: {
                    onSave(viewModel.makePlant())
                    dismiss()
                }
            )
            .padding(.horizontal, 27)
            .padding(.top, 15)

            ScrollView {
                VStack(spacing: 50) {
                    nameField

                    card {
                        FormPickerRow(title: "Room", systemImage: "location", selection: $viewModel.room)
                        rowDivider
                        FormPickerRow(title: "Light", systemImage: "sun.max", selection: $viewModel.light)
                    }

                    card {
                        FormPickerRow(title: "Watering Days", systemImage: "drop", selection: $viewModel.frequency)
                        rowDivider
                        FormPickerRow(title: "Water", systemImage: "drop", selection: $viewModel.waterAmount)
                    }

                    if viewModel.isEditing, let onDelete {
                        deleteButton(onDelete)
                            .padding(.top, 20)
                            .padding(.horizontal, 7)
                    }
                }
                .padding(.horizontal, 17)
                .padding(.top, 59)
            }
        }
        .background(Color.sheetBackground.ignoresSafeArea())
        .presentationBackground(Color.sheetBackground)
    }

    // MARK: - Pieces

    private var nameField: some View {
        HStack(spacing: 8) {
            Text("Plant Name")
            TextField(
                "Pothos",
                text: $viewModel.name,
                prompt: Text("Pothos").foregroundStyle(Color.placeholderGray)
            )
            .tint(Color.plantGreen)
        }
        .font(.body)
        .padding(.horizontal, 19)
        .frame(height: 61)
        .background(Color.cardBackground, in: Capsule())
    }

    private var rowDivider: some View {
        Divider()
            .overlay(Color.separatorGray)
            .padding(.horizontal, 6)
    }

    private func deleteButton(_ action: @escaping () -> Void) -> some View {
        Button {
            action()
            dismiss()
        } label: {
            Text("Delete Reminder")
                .font(.body)
                .foregroundStyle(Color.deleteRed)
                .frame(maxWidth: .infinity)
                .frame(height: 51)
        }
        .buttonStyle(.plain)
        .background(Color.cardBackground, in: Capsule())
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
        }
        .background(Color.cardBackground, in: .rect(cornerRadius: 32))
    }
}

#Preview("Add") {
    PlantFormView(onSave: { _ in })
        .preferredColorScheme(.dark)
}

#Preview("Edit") {
    PlantFormView(plant: Plant.samples[0], onSave: { _ in }, onDelete: {})
        .preferredColorScheme(.dark)
}
