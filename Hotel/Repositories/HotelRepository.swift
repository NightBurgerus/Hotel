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
    func getBookingInfo()
}

final class HotelRepository: HotelRepositoryProtocol {
    func getHotel(completion: @escaping(Response<Hotel>) -> ()) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(Links.hotel).responseDecodable(of: Hotel.self, decoder: jsonDecoder, completionHandler: { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            completion(.success(response.value!))
        })
    }
    func getApartments(completion: @escaping(Response<[Apartment]>) -> ()) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(Links.apartmentsList).responseDecodable(of: ApartmentResponse.self, decoder: jsonDecoder, completionHandler: { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            completion(.success(response.value!.rooms))
        })
    }
    func getBookingInfo() {
        
    }
}
