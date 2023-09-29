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


struct Hotel1: Decodable, Identifiable {
    let id: Int
    let hotelName: String
    let hotelAdress: String
    let horating: Double
    let ratingName: String
    let departure: String
    let arrtivalCountry: String
    let tourDateStart: String
    let tourDateStop: String
    let numberOfNights: Int
    let room: String
    let nutrition: String
    let tourPrice: Double
    let fuelCharge: Double
    let serviceCharge: Double
}


