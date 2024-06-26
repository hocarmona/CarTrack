//
//  AddNewMaintenanceView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/10/24.
//

import SwiftUI

struct AddNewMaintenanceView: View {
    let index: Int
    @State private var maintenanceKm = ""
    @State private var maintenancePlace = ""
    @State private var detailsTf = ""
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: Vehicles
    @State private var alertisPResented = false
    @FocusState private var texFieldFocused: Bool
    @State var maintenanceDate = Date()
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Form {
                Section {
                    VStack {
                        Text("Kilometraje mantenimiento")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Kilometraje", text: $maintenanceKm)
                            .keyboardType(.numberPad)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Ubicacion mantenimiento")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        TextField("Nombre de taller, agencia, etc...", text: $maintenancePlace)
                            .focused($texFieldFocused)
                        Spacer()
                    }
                    VStack {
                        Text("Fecha de mantenimiento")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        DatePicker("Ingresa una fecha", selection: $maintenanceDate,in: ...Date() ,displayedComponents: .date)
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
                    if maintenanceKm != "",
                        maintenancePlace != "" {
                        let maintenance = Maintenance(kilometers: maintenanceKm,
                                                      date: maintenanceDate,
                                                      details: detailsTf,
                                                      place: maintenancePlace)
                        self.vehicles.myVehicles[index].maintenances.append(maintenance)
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
                                                     details: "agencia",
                                                     place: "agencia mazda cuu")],
                          yearModel: 2023,
                          details: "OK", color: codableColor)
    @State var vehicles = Vehicles()
    vehicles.myVehicles = [vehicle]
    @State var refreshView = UUID()
    return AddNewMaintenanceView(index: 0, vehicles: $vehicles)
}
