//  MyPlantsView.swift
//  The main screen. Shows one of four states: empty, nothing due, today's list, or all done.

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
                    .padding(.trailing, 30)
                    .padding(.bottom, 8)
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
        case .nothingDue:
            EmptyStateView(
                title: "Nothing to water today",
                message: "Your plants are all set. Check back tomorrow."
            )
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
        List {
            ReminderProgressView(
                progress: viewModel.progress,
                message: viewModel.progressMessage
            )
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 4, leading: 20, bottom: 12, trailing: 20))

            ForEach(viewModel.todayPlants) { plant in
                PlantRowView(
                    plant: plant,
                    isCompleted: viewModel.isCompleted(plant),
                    onToggle: {
                        withAnimation { viewModel.toggleCompletion(of: plant) }
                    }
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

#Preview("With plants") {
    MyPlantsView(viewModel: PlantListViewModel(
        storage: PlantStorage(fileName: "preview.json"),
        plants: Plant.samples
    ))
    .preferredColorScheme(.dark)
}

#Preview("Empty") {
    MyPlantsView(viewModel: PlantListViewModel(
        storage: PlantStorage(fileName: "preview.json"),
        plants: []
    ))
    .preferredColorScheme(.dark)
}
