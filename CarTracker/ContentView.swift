//
//  ContentView.swift
//  CarTracker
//
//  Created by Hector Carmona on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var vehicles = Vehicles()
    @State var addVehicleValue: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .accentColor],
                               startPoint: .bottom,
                               endPoint: .top)
                .ignoresSafeArea()
                Group {
                    if vehicles.myVehicles.isEmpty || vehicles.myVehicles.count == 0 {
                        NoVehiclesView(addVehicleValue: $addVehicleValue)
                    } else {
                        VehiclesListView(addVehicleValue: $addVehicleValue, vehicles: $vehicles)
                    }
                }

            }
            .toolbarBackground(Color.accentColor)
        }
        .sheet(isPresented: $addVehicleValue, content: {
            NavigationView {
                AddNewVehicleView(vehicles: $vehicles)
            }
        })

    }
    
    func addVehicle() {
        print("add vehicle tapped")
        addVehicleValue = false
    }
}

#Preview {
    ContentView()
}
