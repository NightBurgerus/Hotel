//
//  GeneralTextField.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct GeneralTextField: View {
    var title: String
    var placeholder: String = ""
    @Binding var text: String
    @Binding var error: Bool
    @Binding var isFirstResponder: Bool
    @State private var responder: Bool = false
    var onTextChange: (String) -> () = { _ in }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            if !text.isEmpty {
                Text(title)
                    .customFont(.sfProDisplay(.regular), ofSize: 12)
                    .kerning(0.12)
                    .foregroundColor(R.Colors.gray066)
            }
            TextFieldBridge(currentText: text, isFirstResponder: $responder, placeholder: placeholder, onTextChange: { text = $0 })
                .frame(height: 18)
                .onChange(of: text) { _ in error = false}
                .onChange(of: responder) { newValue in
                    isFirstResponder = newValue
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(error ? R.Colors.error : R.Colors.gray096)
                .overlay(
                    Group {
                        if responder {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(R.Colors.blue)
                        }
                    }
                )
        )
    }
}
