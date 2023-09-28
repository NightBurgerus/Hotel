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
    @State private var isFirstResponder: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .customFont(.sfProDisplay(.regular), ofSize: 12)
                .kerning(0.12)
                .foregroundColor(R.Colors.gray066)
            TextFieldBridge(text: $text, isFirstResponder: $isFirstResponder, placeholder: placeholder)
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
