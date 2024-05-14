//
//  DetailsConteinerCellView.swift
//  CarTracker
//
//  Created by Hector Carmona on 5/13/24.
//

import SwiftUI

struct DetailsConteinerCellView: View {
    let typeOfDetailText: String
    @Binding var detailTextField: String
    @Binding var editingDisabled: Bool
    @FocusState private var focusField: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20, content: {
                Text(typeOfDetailText)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
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
                    Text("Guardar")
                        .foregroundStyle(.blue)
                        .font(.system(size: 16))
                        .onTapGesture {
                            focusField = false
                        }
                }
            })
            TextEditor(text: $detailTextField)
                .frame(minHeight: 120)
                .padding()
                .border(Color.gray, width: 0.5)
                .submitLabel(.return)
                .focused($focusField)
                .onDisappear(perform: {
                    editingDisabled = true
                })
                .onChange(of: focusField) { oldValue, newValue in
                    editingDisabled = !newValue
                }
        }
    }
}

#Preview {
    @State var tf = "orlis"
    @State var editingDisabled = true
    return DetailsConteinerCellView(typeOfDetailText: "Nombre propietario",
                          detailTextField: $tf,
                          editingDisabled: $editingDisabled)
}
