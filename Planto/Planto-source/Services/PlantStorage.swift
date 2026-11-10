//  PlantStorage.swift
//  Saves and loads the plant list as a JSON file so data survives closing the app.

import Foundation

struct PlantStorage {
    private let fileURL: URL

    init(fileName: String = "plants.json") {
        fileURL = URL.documentsDirectory.appending(path: fileName)
    }

    func load() -> [Plant] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        return (try? JSONDecoder().decode([Plant].self, from: data)) ?? []
    }

    func save(_ plants: [Plant]) {
        do {
            let data = try JSONEncoder().encode(plants)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Could not save plants: \(error)")
        }
    }
}
