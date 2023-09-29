//
//  HotelRepository.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation
import Alamofire

protocol HotelRepositoryProtocol {
    func getHotel(completion: @escaping(Response<Hotel>) -> ())
    func getApartments(completion: @escaping(Response<[Apartment]>) -> ())
    func getBookingInfo(completion: @escaping(Response<Booking>) -> ())
}

final class HotelRepository: HotelRepositoryProtocol {
    let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func getHotel(completion: @escaping(Response<Hotel>) -> ()) {
        AF.request(Links.hotel).responseDecodable(of: Hotel.self, decoder: decoder, completionHandler: { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            completion(.success(response.value!))
        })
    }
    func getApartments(completion: @escaping(Response<[Apartment]>) -> ()) {
        AF.request(Links.apartmentsList).responseDecodable(of: ApartmentResponse.self, decoder: decoder, completionHandler: { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            completion(.success(response.value!.rooms))
        })
    }
    func getBookingInfo(completion: @escaping(Response<Booking>) -> ()) {
        AF.request(Links.booking).responseDecodable(of: Booking.self, decoder: decoder, completionHandler: { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            completion(.success(response.value!))
        })
    }
}
