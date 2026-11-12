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
        case empty      // no plants at all
        case today      // some reminders still open
        case allDone    // every reminder for today is checked
    }

    private(set) var plants: [Plant]

    @ObservationIgnored private let storage: PlantStorage
    @ObservationIgnored private let notifications: NotificationManager

    init(
        storage: PlantStorage = PlantStorage(),
        notifications: NotificationManager = .shared,
        plants: [Plant]? = nil
    ) {
        self.storage = storage
        self.notifications = notifications
        self.plants = plants ?? storage.load()
    }

    // MARK: - Values the View displays

    var todayPlants: [Plant] {
        plants.filter { $0.isScheduledForToday() }
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
