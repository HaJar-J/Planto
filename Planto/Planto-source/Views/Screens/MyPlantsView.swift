//  MyPlantsView.swift
//  The main screen. Shows one of three states: empty, today's list, or all done.

import SwiftUI

struct MyPlantsView: View {
    let viewModel: PlantListViewModel

    @State private var formMode: FormMode?

    /// Which version of the form sheet is open.
    enum FormMode: Identifiable {
        case add
        case edit(Plant)

        var id: String {
            switch self {
            case .add: "add"
            case .edit(let plant): plant.id.uuidString
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.appBackground.ignoresSafeArea()

                content

                FloatingAddButton { formMode = .add }
                    .padding(.trailing, 24)
                    .padding(.bottom, 16)
            }
            .navigationTitle("My Plants 🌱")
            .sheet(item: $formMode) { mode in
                switch mode {
                case .add:
                    PlantFormView(onSave: { viewModel.add($0) })
                case .edit(let plant):
                    PlantFormView(
                        plant: plant,
                        onSave: { viewModel.update($0) },
                        onDelete: { viewModel.delete(plant) }
                    )
                }
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.screenState {
        case .empty:
            EmptyStateView(title: "No reminders set yet...")
        case .today:
            plantList
        case .allDone:
            EmptyStateView(
                mood: .winking,
                title: "All Done! 🎉",
                message: "All Reminders Completed"
            )
        }
    }

    private var plantList: some View {
        VStack(spacing: 0) {
            ReminderProgressView(
                progress: viewModel.progress,
                message: viewModel.progressMessage
            )
            .padding(.horizontal)
            .padding(.vertical, 12)

            List {
                ForEach(viewModel.todayPlants) { plant in
                    PlantRowView(
                        plant: plant,
                        isCompleted: viewModel.isCompleted(plant),
                        onToggle: { viewModel.toggleCompletion(of: plant) }
                    )
                    .contentShape(Rectangle())
                    .onTapGesture { formMode = .edit(plant) }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(plant)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .contentMargins(.bottom, 90, for: .scrollContent)
        }
    }
}

#Preview("With plants") {
    MyPlantsView(viewModel: PlantListViewModel(
        storage: PlantStorage(fileName: "preview.json"),
        plants: Plant.samples
    ))
}

#Preview("Empty") {
    MyPlantsView(viewModel: PlantListViewModel(
        storage: PlantStorage(fileName: "preview.json"),
        plants: []
    ))
}
