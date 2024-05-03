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
                    ForEach(cars.indices, id: \.self) { index in
                        ZStack {
                            NavigationLink(value: index) {}
                            .opacity(0)
                            VStack {
                                Text(cars[index])
                                    .font(.title)
                                Rectangle()
                                    .frame(width: .infinity, height: 1, alignment: .center)
                            }
                        }
                        .id(cars[index])
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
            .onAppear(perform: {
                withAnimation {
                    scrollView.scrollTo(cars.last, anchor: .bottom)
                }
            })
            .onChange(of: cars.count, { oldValue, newValue in
                if oldValue > newValue {
                    withAnimation {
                        scrollView.scrollTo(cars.first, anchor: .top)
                    }
                } else {
                    withAnimation {
                        scrollView.scrollTo(cars.last, anchor: .bottom)
                    }
                }
            })
            .navigationDestination(for: Int.self) { i in
                Text("destination \(i)")
            }
        })
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
