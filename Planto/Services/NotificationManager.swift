
import Foundation
import UserNotifications

@MainActor
final class NotificationManager {

    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()

    private init() {}

    /// Requests notification permission.
    func requestAuthorization() async {
        _ = try? await center.requestAuthorization(
            options: [.alert, .sound, .badge]
        )
    }

    /// Schedules recurring plant-watering notifications.
    func schedule(for plant: Plant) {
        cancel(for: plant)

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your \(plant.name) 🌱"
        content.sound = .default

        let seconds = TimeInterval(
            plant.frequency.intervalInDays * 24 * 60 * 60
        )

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: seconds,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

    /// Clears the red app icon badge.
    func clearBadge() async {
        do {
            try await center.setBadgeCount(0)
            print("App badge cleared")
        } catch {
            print("Failed to clear badge: \(error)")
        }
    }

    /// Cancels notifications for a specific plant.
    func cancel(for plant: Plant) {
        center.removePendingNotificationRequests(
            withIdentifiers: [plant.id.uuidString]
        )
    }
}
