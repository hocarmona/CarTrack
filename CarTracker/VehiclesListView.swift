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
                    .foregroundStyle(.black)
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
                            addVehicleValue = true
                        }
                }
                Spacer()
                    .frame(height: 40)
                Text("Mis vehiculos")
                    .foregroundStyle(.black)
                    .font(.system(size: 35,
                                  weight: .medium,
                                  design: .rounded))
                List {
                    ForEach(vehicles.myVehicles.indices, id: \.self) { index in
                        ZStack {
                            NavigationLink(value: index) {}
                            .opacity(0)
                            VStack(alignment: .leading, content: {
                                Text(vehicles.myVehicles[index].name)
                                    .font(.title)
                                    .foregroundStyle(.black)
                                HStack {
                                    Text(vehicles.myVehicles[index].yearModel.description)
                                        .foregroundStyle(.black.opacity(0.8))
                                        .font(.system(size: 20))
                                        .fontWidth(.condensed)
                                    Text(" ✦✦  \(vehicles.myVehicles[index].owner)")
                                        .foregroundStyle(.black.opacity(0.8))
                                        .font(.system(size: 20))
                                        .fontWidth(.condensed)
                                }
                                Spacer()
                                    .frame(width: 120)
                                Rectangle()
                                    .frame(width: .infinity, height: 2, alignment: .center)
                                    .foregroundColor(vehicles.myVehicles[index].color.toColor())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 1.0) // Ajusta el radio según tu preferencia
                                            .stroke(Color.black, lineWidth: 0.3) // Color y ancho del borde
                                    )
                            })
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
                VehicleDetailsView(vehicles: $vehicles, index: i)
            }
        })
        .preferredColorScheme(.dark)
    }
    func removeCar(at offsets: IndexSet) {
        vehicles.myVehicles.remove(atOffsets: offsets)
    }
}

#Preview {
    @State var addVehicleValue: Bool = false
    let color = Color.blue
    let codableColor = CodableColor(color: Color.gray)
    let vehicle = Vehicle(name: "versa 3",
                          owner: "orlando",
                          maintenances: [Maintenance(kilometers: "3500",
                                                     date: Date(),
                                                     details: "agencia",
                                                     place: "agencia mazda cuu")],
                          yearModel: 2023,
                          details: "OK",
                          color: codableColor)
    @State var vehicles = Vehicles()
    vehicles.myVehicles = [vehicle]
    return VehiclesListView(addVehicleValue: $addVehicleValue, vehicles: $vehicles)

}
