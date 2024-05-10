//
//  AddVehicleView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/3/24.
//

import SwiftUI

struct AddNewVehicleView: View {
    @State private var ownerNameTf: String = ""
    @State private var carNameTf: String = ""
    @State private var lastMaintenanceKm = ""
    @State private var lastMaintenancePlace = ""
    @State private var detailsTf = ""
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: Vehicles
    @State private var alertisPResented = false
    @FocusState private var texFieldFocused: Bool
    @State var lastMaintenanceDate = Date()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Form {
                Section {
                    VStack {
                        Text("Nombre del propietario")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Nombre o alias", text: $ownerNameTf)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Nombre de carro")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Marca, modelo o alias", text: $carNameTf)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Ultimo mantenimiento (KM)")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Kilometraje de ultimo mantenimiento", text: $lastMaintenanceKm)
                            .keyboardType(.numberPad)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Ubicacion ultimo mantenimiento")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Nombre de taller, agencia, etc...", text: $lastMaintenancePlace)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Fecha de ultimo mantenimiento")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        DatePicker("Ingresa una fecha", selection: $lastMaintenanceDate,in: ...Date() ,displayedComponents: .date)
                        Spacer()
                            .frame(height: 20)
                        Spacer()
                        Text("Detalles (opcional):")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        Text("Costo, tipo de mantenimiento, mecanico en turno, etc...")
                            .frame(width: UIScreen.main.bounds.width * 0.73)
                            .foregroundStyle(.gray)
                            .fixedSize()
                            .font(.footnote)
                        TextEditor(text: $detailsTf)
                            .frame(minHeight: 150)
                            .padding()
                            .border(Color.gray, width: 0.5)
                            .focused($texFieldFocused)
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
        }
        .alert("Enter valid data", isPresented: $alertisPResented, actions: {
            Button("Done") {
                alertisPResented = false
            }
        })
        .navigationTitle("Agregar vehiculo")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Guardar") {
                    if carNameTf != "",
                       lastMaintenanceKm != "",
                        ownerNameTf != "",
                        lastMaintenancePlace != "" {
                        guard let kilometers = Int(lastMaintenanceKm) else { return }
                        let maintenance = Maintenance(kilometers: kilometers,
                                                      date: lastMaintenanceDate,
                                                      details: detailsTf,
                                                      place: lastMaintenancePlace)
                        let vehicle = Vehicle(name: carNameTf,
                                              owner: ownerNameTf,
                                              maintenances: [maintenance])
                        self.vehicles.myVehicles.append(vehicle)
                        dismiss()
                    } else {
                        alertisPResented = true
                    }
                }

            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") {
                    texFieldFocused = false
                }
            }
        }

    }
}

#Preview {
    @State var vehicles = Vehicles()
    return AddNewVehicleView(vehicles: $vehicles)
}
