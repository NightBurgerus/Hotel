//
//  PhoneTextField.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct PhoneTextField: View {
    @Binding var phone: String
    @State private var isFirstResponder = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Номер телефона")
                .customFont(.sfProDisplay(.regular), ofSize: 12)
                .kerning(0.12)
                .foregroundColor(R.Colors.gray066)
            PhoteTextFieldBridge(text: $phone, isFirstResponder: $isFirstResponder)
                .foregroundColor(.red)
                .frame(height: 18)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(R.Colors.gray096)
                .overlay(
                    Group {
                        if isFirstResponder {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(R.Colors.blue)
                        }
                    }
                )
        )
    }
}
