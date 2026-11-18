//  PlantListViewModel.swift
//  Owns the list of plants and all the logic the main screen needs.
//  The View only reads these values and calls these functions.

import Foundation
import Observation

@MainActor
@Observable
final class PlantListViewModel {

    /// Which version of the main screen to show.
    enum ScreenState {
        case empty       // no plants at all
        case nothingDue  // plants exist, but none are due today
        case today       // some reminders are still open
        case allDone     // every reminder due today is checked
    }

    private(set) var plants: [Plant]

    @ObservationIgnored private let storage: PlantStorage
    @ObservationIgnored private let notifications: NotificationManager

    init(
        storage: PlantStorage? = nil,
        notifications: NotificationManager? = nil,
        plants: [Plant]? = nil
    ) {
        let storage = storage ?? PlantStorage()
        self.storage = storage
        self.notifications = notifications ?? .shared
        self.plants = plants ?? storage.load()
    }

    // MARK: - Values the View displays

    /// Today's reminders: pending first, then completed.
    /// Each group keeps its original order.
    var todayPlants: [Plant] {
        let due = plants.filter { $0.isScheduledForToday() }
        return due.filter { !$0.isWateredToday() } + due.filter { $0.isWateredToday() }
    }

    var completedCount: Int {
        todayPlants.filter { $0.isWateredToday() }.count
    }

    var progress: Double {
        guard !todayPlants.isEmpty else { return 0 }
        return Double(completedCount) / Double(todayPlants.count)
    }

    var progressMessage: String {
        completedCount == 0
            ? "Your plants are waiting for a sip 💦"
            : "\(completedCount) of your plants feel loved today ✨"
    }

    var screenState: ScreenState {
        if plants.isEmpty { return .empty }
        if todayPlants.isEmpty { return .nothingDue }
        return todayPlants.allSatisfy { $0.isWateredToday() } ? .allDone : .today
    }

    func isCompleted(_ plant: Plant) -> Bool {
        plant.isWateredToday()
    }

    // MARK: - Actions the View can trigger

    func add(_ plant: Plant) {
        plants.append(plant)
        save()
        Task {
            await notifications.requestAuthorization()
            notifications.schedule(for: plant)
        }
    }

    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
        save()
        notifications.schedule(for: plant)
    }

    func delete(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        notifications.cancel(for: plant)
        save()
    }

    func toggleCompletion(of plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].lastWateredDate = plants[index].isWateredToday() ? nil : Date()
        save()
    }

    private func save() {
        storage.save(plants)
    }
}
