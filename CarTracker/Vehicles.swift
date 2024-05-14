//
//  Vehicles.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/3/24.
//

import SwiftUI

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
    var yearModel: Int
    var details: String
    var color: CodableColor
}

struct Maintenance: Codable, Identifiable {
    var id = UUID()
    var kilometers: Int
    var date: Date
    var details: String
    var place: String
}

struct CodableColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.alpha = Double(alpha)
    }

    func toColor() -> Color {
        return Color(UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha)))
    }
}
