//
//  GeneralButton.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

/// __Общая вид кнопки__
/// Белый текст на голубом фоне

struct GeneralButton: View {
    let text: String
    var action: () -> () = {}
    var body: some View {
        Button {
            action()
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
