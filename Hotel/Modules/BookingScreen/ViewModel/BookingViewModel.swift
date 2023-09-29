//
//  BookingViewModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

protocol BookingViewModelProtocol: ObservableObject {
    var info: Booking? { get }
    var hotelName: String { get }
    var hotelAddress: String { get }
    var departmentInfo: [(row: String, data: String)] { get }
    var phoneNumber: String { get set }
    var email: String { get set }
    var tourPrice: String { get }
    var fuelCharge: String { get }
    var serviceCharge: String { get }
    var totalPrice: String { get }
    func getInfo()
}
