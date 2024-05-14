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
    @State private var detailsTf = ""
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: Vehicles
    @State private var alertisPResented = false
    @FocusState private var texFieldFocused: Bool
    @State var lastMaintenanceDate = Date()
    @State private var selectedYear: Int = 2023
    @State private var carColor: Color = .clear
    let startYear: Int
    let endYear: Int
    
    init(vehicles: Binding<Vehicles>) {
        self._vehicles = vehicles
        let currentYear = Calendar.current.component(.year, from: Date())
        self.startYear = currentYear - 100
        self.endYear = currentYear + 1
        self.selectedYear = endYear
    }
    
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
                        Text("Modelo vehiculo (año)")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        Picker("Año", selection: $selectedYear) {
                            ForEach(startYear...endYear, id: \.self) { year in
                                Text(String(format: "%d", year)).tag(year)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        Spacer()
                            .frame(height: 20)
                        Spacer()
                        ColorPicker("Color de vehiculo",
                                    selection: $carColor, supportsOpacity: false)
                        Spacer()
                            .frame(height: 20)
                        Text("Detalles (opcional):")
                            .lineLimit(1)
                            .fixedSize()
                            .font(.title2)
                        Text("Alguna caracteristica adicional del carro, notas, pendientes, etc...")
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
                        ownerNameTf != "" {
                        let codableColor = CodableColor(color: carColor)
                        let vehicle = Vehicle(name: carNameTf,
                                        owner: ownerNameTf,
                                        maintenances: [],
                                        yearModel: selectedYear,
                                        details: detailsTf,
                                              color: codableColor)
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
