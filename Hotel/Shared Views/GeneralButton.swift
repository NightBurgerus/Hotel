//
//  GeneralButton.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct GeneralButton: View {
    let text: String
    var body: some View {
        Button {
            print("~ general button tap")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15).fill(R.Colors.blue)
                Text(text)
                    .customFont(.sfProDisplay(.medium), ofSize: 16)
                    .kerning(0.1)
                    .foregroundColor(Color.white)
                    .padding(.top, 15)
                    .padding(.bottom, 14)
            }
            .frame(height: 48)
        }

    }
}
