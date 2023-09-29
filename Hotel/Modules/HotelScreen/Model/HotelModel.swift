//
//  HotelModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

struct Hotel: Decodable, Identifiable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Double
    let priceForIt: String
    let rating: Double
    let ratingName: String
    let imageUrls: [URL]
    let aboutTheHotel: AboutHotel
}

struct AboutHotel: Decodable {
    let description: String
    let peculiarities: [String]
}
