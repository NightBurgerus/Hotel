//
//  RatingView.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

/// __Рейтинг отеля/номера__

enum RatingPlacement {
    case leading, center, trailing
}

struct RatingView: View {
    let rating: Double
    let ratingName: String
    let placement: RatingPlacement = .leading
    
    var body: some View {
        HStack {
            if placement == .trailing {
                Spacer()
            }
            
            // Main Content
            HStack(spacing: 2) {
                R.Images.StarImage
                    .frame(width: 15, height: 15)
                Text("\(rating.formatted) \(ratingName)")
                    .customFont(.sfProDisplay(.medium), ofSize: 16)
                    .foregroundColor(R.Colors.orange)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(RoundedRectangle(cornerRadius: 5).fill(R.Colors.lightOrange))
            
            if placement == .leading {
                Spacer()
            }
        }
    }
}
