//
//  Vehicles.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/3/24.
//

import Foundation

@Observable
class Vehicles: Codable {
    var myVehicles = [Vehicle]() {
        didSet {
            if let data = try? JSONEncoder().encode(myVehicles) {
                UserDefaults.standard.setValue(data, forKey: GlobalConstants.myVehiclesUdKey)
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: GlobalConstants.myVehiclesUdKey),
           let vehicles = try? JSONDecoder().decode([Vehicle].self, from: data) {
            myVehicles = vehicles
            return
        }
        myVehicles = []
    }
}

struct Vehicle: Codable, Identifiable {
    var id = UUID()
    var name: String
    var owner: String
    var maintenances: [Maintenance]
}

struct Maintenance: Codable, Identifiable {
    var id = UUID()
    var kilometers: Int
    var date: Date
    var details: String
    var place: String
}
