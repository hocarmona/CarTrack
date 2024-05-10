//
//  VehicleDetailsView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/7/24.
//

import SwiftUI

struct VehicleDetailsView: View {
    @Binding var vehicles: Vehicles
    let index: Int
//    @FocusState private var texFieldFocused: Bool
    @State var detailTextField: String = ""
    @State var vehicleDisabled: Bool = true
    @State var ownerDisabled: Bool = true
    @State var addMaintenance: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DetailCellView(typeOfDetailText: GlobalConstants.vehicleName,
                                   detailTextField: $vehicles.myVehicles[index].name,
                                   editingDisabled: $vehicleDisabled)
                    DetailCellView(typeOfDetailText: GlobalConstants.propertyName,
                                   detailTextField: $vehicles.myVehicles[index].owner,
                                   editingDisabled: $ownerDisabled)
                }
                Section("Mantenimientos") {
                    VStack(spacing: 2) {
                        HStack(content: {
                            Spacer()
                            VStack(alignment: .center, spacing: 2) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 35))
                                    .onTapGesture {
                                        addMaintenance = true
                                    }
                                    .foregroundColor(.blue)
                                Text("Agregar")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 14))
                                    .fontWidth(.compressed)
                            }
                            Spacer()
                        })
                    }
                    ForEach(vehicles.myVehicles[index].maintenances) { maintenance in
                        let place = maintenance.place
                        let kilometers = maintenance.kilometers
                        ZStack {
                            NavigationLink(value: String(index)) {}
                            .opacity(0)
                            VStack(alignment: .leading, spacing: 5, content: {
                                HStack {
                                    Text(place)
                                        .fontWidth(.condensed)
                                        .bold()
                                    Spacer()
                                    Text(maintenance.date, style: .date)
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.gray)
                                }
                                Text("Kilometraje: \(kilometers) km")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color.black.opacity(0.6))
                            })
                        }
                        .listRowBackground(Color.white)
                    }
                    .onDelete(perform: removeMaintenance)
                    .onAppear {
                        vehicles.myVehicles[index].maintenances.sort { first, second in
                            return first.date > second.date
                        }
                    }
                }
                .font(.system(size: 18))
                
            }
            .onAppear(perform: {
                detailTextField = vehicles.myVehicles[index].name
            })
            .navigationTitle("Detalles")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {

            }
        }
        .sheet(isPresented: $addMaintenance, content: {
            NavigationView {
                Text("add maintenance view")
            }
        })
        .navigationDestination(for: String.self) { i in
            Text("maintenance \(i)")
        }
    }
    func removeMaintenance(at offsets: IndexSet) {
        vehicles.myVehicles[index].maintenances.remove(atOffsets: offsets)
    }
}

#Preview {
    let vehicle =  Vehicle(name: "versa 3",
                           owner: "orlando",
                           maintenances: [Maintenance(kilometers: 3500,
                                                      date: Date(),
                                                      details: "agencia",
                                                      place: "agencia mazda cuu")])
    @State var vehicles = Vehicles()
    vehicles.myVehicles = [vehicle]
    return VehicleDetailsView(vehicles: $vehicles, index: 0)
}
