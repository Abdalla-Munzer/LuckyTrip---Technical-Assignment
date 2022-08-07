//
//  UserDefaultsManager.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import Foundation
class UserDefaultsManager {
    // MARK: Singleton
    static let shared = UserDefaultsManager()
    private let userDefault = UserDefaults.standard

    var savedDestination: [Destination] {
        get {
            guard let data = userDefault.data(forKey: "SavedDestination") else { return [] }
            return (try? JSONDecoder().decode([Destination].self, from: data)) ?? []
        }
        set(destination) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(destination) {
                userDefault.set(encoded, forKey: "SavedDestination")
            }
        }
    }
}
