//
//  DetailCellView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/8/24.
//

import SwiftUI

struct DetailCellView: View {
    let typeOfDetailText: String
    @Binding var detailTextField: String
    @Binding var editingDisabled: Bool
    @FocusState private var focusField: Bool
    var body: some View {
        VStack {
            Text(typeOfDetailText)
            HStack {
                TextField("", text: $detailTextField)
                    .focused($focusField)
                    .submitLabel(.done)
                    .onSubmit() {
                        focusField = false
                        editingDisabled = true
                    }
                    .onDisappear(perform: {
                        editingDisabled = true
                    })
                    .onChange(of: focusField) { oldValue, newValue in
                        editingDisabled = !newValue
                    }
                if editingDisabled {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                        .scaledToFit()
                        .onTapGesture(perform: {
                            self.editingDisabled = false
                            self.focusField = true
                        })
                } else {
                    Text("editing")
                        .foregroundStyle(.gray)
                        .font(.system(size: 16))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @State var tf = "orlis"
    @State var editingDisabled = true
    return DetailCellView(typeOfDetailText: "Nombre propietario",
                          detailTextField: $tf,
                          editingDisabled: $editingDisabled)
}
