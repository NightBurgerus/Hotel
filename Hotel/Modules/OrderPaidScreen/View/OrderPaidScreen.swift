//
//  OrderPaidScreen.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

struct OrderPaidScreen: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer().frame(height: 122)
                R.Images.PartyEmoji
                    .padding(25)
                    .background(Circle().fill(R.Colors.gray246))
                    .padding(.bottom, 32)
                
                Text(R.Strings.OrderPaid.accepted)
                    .customFont(.sfProDisplay(.medium), ofSize: 22)
                    .foregroundColor(.black)
                
                Text(R.Strings.OrderPaid.confirmation(number: Int.random(in: 0..<Int.max)))
                    .customFont(.sfProDisplay(.regular), ofSize: 16)
                    .multilineTextAlignment(.center)
                    .foregroundColor(R.Colors.gray)
                    .padding(.top, 20)
                Spacer()
            }
            .padding(16)
            
            button
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    print("~ tap")
                } label: {
                    R.Images.ArrowLeftImage
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(R.Strings.OrderPaid.title)
                    .customFont(.sfProDisplay(.medium), ofSize: 18)
                    .foregroundColor(Color.black)
            }
        }
    }
    
    var button: some View {
        VStack {
            Spacer()
                
            GeneralButton(text: R.Strings.OrderPaid.super)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
                .background(Color.white)
                .border(R.Colors.gray232)
        }
    }
}

struct OrderPaidScreenPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderPaidScreen()
        }
    }
}
