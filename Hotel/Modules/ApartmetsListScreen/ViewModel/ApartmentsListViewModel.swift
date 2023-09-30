//
//  ApartmentsListViewModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation
import OSLog

protocol ApartmentsListViewModelProtocol: ObservableObject {
    var rooms: [Apartment] { get }
    func getApartments(completion: @escaping() -> ())
}

final class ApartmentsListViewModel: ApartmentsListViewModelProtocol {
    @Published var rooms: [Apartment] = []
    private var repository: HotelRepositoryProtocol
    private let logger = Logger()
    
    init(repository: HotelRepositoryProtocol){
        self.repository = repository
    }
    
    func getApartments(completion: @escaping() -> ()) {
        repository.getApartments { response in
            completion()
            switch response {
            case .success(let rooms):
                self.rooms = rooms
            case .failure(let error):
                self.logger.error("Apartments list VM error: \(error)")
            }
        }
    }
}
