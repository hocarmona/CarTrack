//
//  ContentView.swift
//  CarTracker
//
//  Created by Hector Carmona on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var cars = ["sonic", "mazda", "aveo", "colorado", "versa", "chevy", "golf", "raptor", "civic", "golf", "raptor", "civiccc"]
//    @State var cars: [String] = []

    @State var addVehicleValue: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .accentColor],
                               startPoint: .bottom,
                               endPoint: .top)
                .ignoresSafeArea()
                Group {
                    if cars.isEmpty || cars.count == 0 {
                        AddVehicleView(addVehicleValue: $addVehicleValue)
                    } else {
                        VehiclesListView(addVehicleValue: $addVehicleValue, cars: $cars)
                    }
                }

            }
            .toolbarBackground(Color.accentColor)
        }
        .sheet(isPresented: $addVehicleValue, content: {
            Text("add")
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
