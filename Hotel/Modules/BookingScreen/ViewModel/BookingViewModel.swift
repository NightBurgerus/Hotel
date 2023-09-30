//
//  BookingViewModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI
import OSLog
import Combine

protocol BookingViewModelProtocol: ObservableObject {
    var info: Booking? { get }
    var hotelName: String { get }
    var hotelAddress: String { get }
    var rating: Double { get }
    var ratingName: String { get }
    var departmentInfo: [(row: String, data: String)] { get }
    var tourPrice: String { get }
    var fuelCharge: String { get }
    var serviceCharge: String { get }
    var totalPrice: String { get }
    
    var phoneNumber: String { get set }
    var phoneIsFirstResponder: Bool { get set }
    var phoneError: Bool { get set }
    
    var email: String { get set }
    var emailIsFirstResponder: Bool { get set }
    var emailError: Bool { get set }
    
    var tourists: [TouristFieldModel] { get set }
    
    func getInfo()
    func addTourist()
}

final class BookingViewModel: BookingViewModelProtocol {
    private let repository: HotelRepositoryProtocol
    private let logger = Logger()
    private let validator = Validator()
    private var cancellableSet = Set<AnyCancellable>()
    @Published private(set) var info: Booking?
    
    // Phone Field
    @Published var phoneNumber  = ""
    @Published var phoneIsFirstResponder = false
    @Published var phoneError = false
    
    // Email Field
    @Published var email: String = ""
    @Published var emailIsFirstResponder = false
    @Published var emailError = false
    
    @Published var tourists: [TouristFieldModel] = [TouristFieldModel(tourist: Tourist())]
    
    init(repository: HotelRepositoryProtocol){
        self.repository = repository
        
        // Прокидываем изменение полей ошибок туристов
        for tourist in tourists {
            tourist
                .objectWillChange
                .sink { _ in
                    self.objectWillChange.send()
                }
                .store(in: &cancellableSet)
        }
    }
    
    func getInfo() {
        repository.getBookingInfo { response in
            switch response {
            case .success(let info):
                self.info = info
                self.initReactive()
            case .failure(let error):
                self.logger.error("Booking view model error: \(error)")
            }
        }
    }
    
    func addTourist() {
        tourists.append(TouristFieldModel(tourist: Tourist()))
    }
}

extension BookingViewModel {
    var hotelName: String {
        info?.hotelName ?? ""
    }
    var hotelAddress: String {
        info?.hotelAdress ?? ""
    }
    
    var rating: Double {
        guard let info = info else { return 0 }
        return info.horating
    }
    
    var ratingName: String {
        guard let info = info else { return "" }
        return info.ratingName
    }
    
    var departmentInfo: [(row: String, data: String)] {
        guard let info = info else { return [] }
        
        return [
            (R.Strings.Booking.departure, info.departure),
            (R.Strings.Booking.arrivalCountry, info.arrivalCountry),
            (R.Strings.Booking.tourDates, "\(info.tourDateStart) – \(info.tourDateStop)"),
            (R.Strings.Booking.numberOfNights, "\(info.numberOfNights) ночей"),
            (R.Strings.Booking.hotel, info.hotelName),
            (R.Strings.Booking.room, info.room),
            (R.Strings.Booking.nutrition, info.nutrition)
        ]
    }
    var tourPrice: String {
        guard let info = info else { return "" }
        return "\(info.tourPrice.formatted) ₽"
    }
    
    var fuelCharge: String {
        guard let info = info else { return "" }
        return "\(info.fuelCharge.formatted) ₽"
    }
    
    var serviceCharge: String {
        guard let info = info else { return "" }
        return "\(info.serviceCharge.formatted) ₽"
    }
    
    var totalPrice: String {
        guard let info = info else { return "" }
        let total = info.tourPrice + info.fuelCharge + info.serviceCharge
        return "\(total.formatted) ₽"
    }
}

extension BookingViewModel {
    func initReactive() {
        /// При изменении респондера проверяется, корректный ли телефон
        $phoneIsFirstResponder
            .dropFirst()
            .debounce(for: 0.3, scheduler: RunLoop.current)
            .map { responder in
                if responder { return false }
                return !self.validator.isValidPhone(self.phoneNumber)
            }
            .sink(receiveValue: {
                self.phoneError = $0
            })
            .store(in: &cancellableSet)
        
        $emailIsFirstResponder
            .dropFirst()
            .debounce(for: 0.3, scheduler: RunLoop.current)
            .map { responder in
                if responder { return false }
                return !self.validator.isValidEmail(self.email)
            }
            .sink(receiveValue: {
                self.emailError = $0
            })
            .store(in: &cancellableSet)
    }
}
