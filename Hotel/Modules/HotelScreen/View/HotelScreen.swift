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
            PhotoCarouselView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Hotel.title)
                    .sfProDisplayFont(ofWeight: 500, size: 18)
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
