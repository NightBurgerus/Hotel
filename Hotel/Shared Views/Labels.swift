//
//  Labels.swift
//  Hotel
//
//  Created by Чебупелина on 27.09.2023.
//

import SwiftUI

struct GeneralLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .sfProDisplayFont(ofWeight: 500, size: 16)
            .foregroundColor(R.Colors.gray)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(RoundedRectangle(cornerRadius: 5).fill(R.Colors.lightGray))
    }
}

struct LinkedLabel: View {
    @State private var size: CGSize? = nil
    let text: String
    var body: some View {
            Text(text)
                .sfProDisplayFont(ofWeight: 500, size: 16)
                .foregroundColor(R.Colors.blue)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(R.Colors.blue.opacity(0.1))
                            .padding(.vertical, -5)
                            .padding(.leading, -10)
                            
                        HStack {
                            Spacer()
                            R.Images.ArrowRightImage
                                .padding(.trailing, 2 + 8)
                        }
                    }.padding(.trailing, -17 - 2 - 10)
                )
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 47))
                
        
    }
}
