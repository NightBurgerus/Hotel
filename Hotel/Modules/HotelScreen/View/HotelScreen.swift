//
//  HotelScreen.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct HotelScreen: View {
    var body: some View {
        VStack {
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Hotel.title)
                    .customFont(.sfProDisplay(.heavyItalic), ofSize: 16)
            }
        }
    }
}

struct HotelScreenPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelScreen()
        }
    }
}
