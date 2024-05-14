//
//  MaintenanceDetailView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/13/24.
//

import SwiftUI

struct MaintenanceDetailView: View {
    @Binding var vehicles: Vehicles
    @FocusState private var detailsTextFieldFocused: Bool
    @State var detailTextField: String = ""
    @State var kilometersDisabled: Bool = true
    @State var locationDisabled: Bool = true
    @State var detailsDisabled: Bool = true
    @State var addMaintenance: Bool = false
    @State var alertisPResented: Bool = false
    @State var maintenanceDate = Date()
    let index: Int
    let maintIndex: Int
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DetailCellView(typeOfDetailText: GlobalConstants.maintDetailKm,
                                   detailTextField: $vehicles.myVehicles[index].maintenances[maintIndex].kilometers,
                                   editingDisabled: $kilometersDisabled)
                    DetailCellView(typeOfDetailText: GlobalConstants.locationMaint,
                                   detailTextField: $vehicles.myVehicles[index].maintenances[maintIndex].place,
                                   editingDisabled: $locationDisabled)
                    VStack(alignment: .center, content: {
                        Text("Fecha de mantenimiento")
                        DatePicker("Ingresa una fecha", selection: $maintenanceDate,in: ...Date() ,displayedComponents: .date)
                            .labelsHidden()
                    })
                    DetailsConteinerCellView(typeOfDetailText: GlobalConstants.details, detailTextField: $vehicles.myVehicles[index].maintenances[maintIndex].details,
                                             editingDisabled: $detailsDisabled)
                    Text("Al editar algun dato no podras recuperarlo previo a la edicion")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
            }
            .onAppear(perform: {
                detailTextField = vehicles.myVehicles[index].name
                maintenanceDate = vehicles.myVehicles[index].maintenances[maintIndex].date
            })
            .navigationTitle("Detalles mantenimiento")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $addMaintenance, content: {
            NavigationView {
                AddNewMaintenanceView(index: index, vehicles: $vehicles)
            }
        })
        .navigationDestination(for: String.self) { i in
            if let maintIndex = Int(i) {
                MaintenanceDetailView(vehicles: $vehicles,
                                      index: index,
                                      maintIndex: maintIndex)
            } else {
                Text("Detalles no disponibles")
            }
        }
        .alert("Detalles no disponibles", isPresented: $alertisPResented, actions: {
            Button("Done") {
                alertisPResented = false
            }
        })
        .preferredColorScheme(.dark)
    }
}


#Preview {
    let color = Color.blue
    let codableColor = CodableColor(color: Color.gray)
    let vehicle = Vehicle(name: "versa 3",
                          owner: "orlando",
                          maintenances: [Maintenance(kilometers: "3500",
                                                     date: Date(),
                                                     details: "ok",
                                                     place: "agencia mazda cuu")],
                          yearModel: 2023,
                          details: "OK", color: codableColor)
    @State var vehicles = Vehicles()
    vehicles.myVehicles = [vehicle]
    return MaintenanceDetailView(vehicles: $vehicles, index: 0, maintIndex: 0)
}
