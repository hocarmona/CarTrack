//
//  ContentView.swift
//  CarTracker
//
//  Created by Hector Carmona on 4/30/24.
//

import SwiftUI

struct ContentView: View {
//    @State var cars = ["sonic", "mazda", "aveo", "colorado", "versa"]
    @State var cars: [String] = []
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .accentColor],
                               startPoint: .bottom,
                               endPoint: .top)
                .ignoresSafeArea()
                Group {
                    if cars.isEmpty || cars.count == 0 {
                        VStack(spacing: 90, content: {
                            ZStack(content: {
                                RoundedRectangle(cornerSize: CGSize(width: 30, height: 40), style: .continuous)
                                    .foregroundStyle(Color.white.opacity(0.2))
                                    .frame(width: 300, height: 100)
                                Text("No vehiculos registrados")
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.black)
                                    .font(.system(.largeTitle,
                                                  design: .rounded,
                                                  weight: .bold))
                                    .frame(width: UIScreen.main.bounds.width - 20)
                            })
                            VStack(spacing: 15, content: {
                                Image(.botonMas)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .onTapGesture {
                                        addVehicle()
                                    }
                                Text("Agregar")  
                                    .foregroundStyle(.black)
                                    .font(.system(.title,
                                                  design: .monospaced,
                                                  weight: .medium))
                            })
                        })
                    } else {
                        List {
                            ForEach(cars, id: \.self) { car in
                                VStack {
                                    Text(car)
                                        .font(.title)
                                    Rectangle()
                                        .frame(width: .infinity, height: 1, alignment: .center)
                                }
                            }
                            .onDelete(perform: removeCar)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                }

            }
        }
    }
    
    func removeCar(at offsets: IndexSet) {
        cars.remove(atOffsets: offsets)
    }
    
    func addVehicle() {
        print("add vehicle tapped")
    }
}

#Preview {
    ContentView()
}
