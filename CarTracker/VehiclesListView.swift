//
//  VehiclesListView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/2/24.
//

import SwiftUI

struct VehiclesListView: View {
    @Binding var addVehicleValue: Bool
    @Binding var vehicles: Vehicles
    
    var body: some View {
        ScrollViewReader(content: { scrollView in
            VStack {
                Spacer()
                    .frame(height: 15)
                Text("Agregar vehiculo")
                    .font(.system(size: 20,
                                  weight: .medium,
                                  design: .rounded))
                ZStack {
                    Circle()
                        .foregroundStyle(Color.white.opacity(0.1))
                        .frame(width: 100, height: 100)
                    Image(.botonMas)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            print("add tapped")
                            addVehicleValue = true
                        }
                }
                Spacer()
                    .frame(height: 40)
                Text("Mis vehiculos")
                    .font(.system(size: 35,
                                  weight: .medium,
                                  design: .rounded))
                List {
                    ForEach(vehicles.myVehicles.indices, id: \.self) { index in
                        ZStack {
                            NavigationLink(value: index) {}
                            .opacity(0)
                            VStack {
                                Text(vehicles.myVehicles[index].name)
                                    .font(.title)
                                Rectangle()
                                    .frame(width: .infinity, height: 1, alignment: .center)
                            }
                        }
//                        .id(vehicles.myVehicles[index])
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: removeCar)
                    .listRowSeparator(.hidden)
                    .preferredColorScheme(.light)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .listStyle(.plain)
                Spacer()
            }
//            .onAppear(perform: {
//                withAnimation {
//                    scrollView.scrollTo(vehicles.last, anchor: .bottom)
//                }
//            })
//            .onChange(of: vehicles.count, { oldValue, newValue in
//                if oldValue > newValue {
//                    withAnimation {
//                        scrollView.scrollTo(vehicles.first, anchor: .top)
//                    }
//                } else {
//                    withAnimation {
//                        scrollView.scrollTo(vehicles.last, anchor: .bottom)
//                    }
//                }
//            })
            .navigationDestination(for: Int.self) { i in
                let vehicle = vehicles.myVehicles[i]
                Text("\(vehicle.name)\n \(vehicle.owner)\n\(vehicle.maintenances[0].kilometers)\n\(vehicle.maintenances[0].details)")
            }
        })
    }
    func removeCar(at offsets: IndexSet) {
        vehicles.myVehicles.remove(atOffsets: offsets)
//        vehicles.remove(atOffsets: offsets)
    }
}

#Preview {
    @State var addVehicleValue: Bool = false
    @State var cars = ["sonic", "mazda", "aveo", "colorado", "versa"]
    let vehicle =  Vehicle(name: "versa 3", owner: "orlando", maintenances: [Maintenance(kilometers: 3500, date: Date(), details: "agencia")])
    @State var vehicles = Vehicles()
    vehicles.myVehicles = [vehicle]
    return VehiclesListView(addVehicleValue: $addVehicleValue, vehicles: $vehicles)

}
