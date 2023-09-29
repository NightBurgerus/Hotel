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
    
    private var showTitle: Bool {
        if isFirstResponder {
            return true
        }
        if phone.count - phone.replacingOccurrences(of: "*", with: "").count != 10 && !phone.isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showTitle {
                Text(R.Strings.Booking.phoneNumber)
                    .customFont(.sfProDisplay(.regular), ofSize: 12)
                    .kerning(0.12)
                    .foregroundColor(R.Colors.gray066)
            }
            PhoneTextFieldBridge(text: $phone, isFirstResponder: $isFirstResponder, placeholder: R.Strings.Booking.phoneNumber)
                .foregroundColor(.red)
                .frame(height: 18)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(height: 52)
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