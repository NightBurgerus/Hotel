//
//  ApartmentsListModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

struct ApartmentResponse: Decodable {
    let rooms: [Apartment]
}

struct Apartment: Identifiable, Decodable {
    let id: Int
    let name: String
    let price: Double
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [URL]
}
