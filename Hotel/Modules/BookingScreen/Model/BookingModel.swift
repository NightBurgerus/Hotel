//
//  BookingModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

struct Booking: Decodable, Identifiable {
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
