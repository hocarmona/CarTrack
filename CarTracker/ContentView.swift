//
//  ContentView.swift
//  CarTracker
//
//  Created by Hector Carmona on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var cars = ["sonic", "mazda", "aveo", "colorado", "versaaa"]
//    @State var cars: [String] = []

    @State var addVehicleValue: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .accentColor],
                               startPoint: .bottom,
                               endPoint: .top)
                .if(cars.isEmpty) { $0.ignoresSafeArea() }
                Group {
                    if cars.isEmpty || cars.count == 0 {
                        AddVehicleView(addVehicleValue: $addVehicleValue)
                    } else {
                        VehiclesListView(addVehicleValue: $addVehicleValue, cars: $cars)
                    }
                }

            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        addVehicleValue = true
                    }
                }
            })
//            .navigationTitle("hola")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
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
