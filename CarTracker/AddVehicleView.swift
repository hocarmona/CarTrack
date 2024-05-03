//
//  AddVehicleView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/2/24.
//

import SwiftUI

struct AddVehicleView: View {
    @Binding var addVehicleValue: Bool
    var body: some View {
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
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        print("add tapped")
                        addVehicleValue = true
                    }
                Text("Agregar")
                    .foregroundStyle(.black)
                    .font(.system(.title,
                                  design: .monospaced,
                                  weight: .medium))
            })
        })
    }
}

#Preview {
    @State var addVehicleValue: Bool = false
    return AddVehicleView(addVehicleValue: $addVehicleValue)
}
