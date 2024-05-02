//
//  VehiclesListView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/2/24.
//

import SwiftUI

struct VehiclesListView: View {
    @Binding var addVehicleValue: Bool
    @Binding var cars: [String]
    var body: some View {
        List {
            ForEach(cars, id: \.self) { car in
                VStack {
                    Text(car)
                        .font(.title)
                    Rectangle()
                        .frame(width: .infinity, height: 1, alignment: .center)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete(perform: removeCar)
            .listRowSeparator(.hidden)
            .preferredColorScheme(.light)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .listStyle(.plain)
    }
    
    func removeCar(at offsets: IndexSet) {
        cars.remove(atOffsets: offsets)
    }
}

#Preview {
    @State var addVehicleValue: Bool = false
    @State var cars = ["sonic", "mazda", "aveo", "colorado", "versa"]
    return VehiclesListView(addVehicleValue: $addVehicleValue, cars: $cars)
}
