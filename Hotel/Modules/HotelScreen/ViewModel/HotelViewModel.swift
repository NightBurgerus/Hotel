//
//  HotelViewModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI
import OSLog

protocol HotelViewModelProtocol: AnyObject, ObservableObject {
    var info: Hotel? { get }
    func loadData(completion: @escaping() -> ())
}

final class HotelViewModel: HotelViewModelProtocol {
    @Published private(set) var info: Hotel? = nil
    private let logger = Logger()
    private let repository: HotelRepositoryProtocol
    
    init(repository: HotelRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadData(completion: @escaping() -> ()) {
        repository.getHotel { response in
            completion()
            switch response {
            case .success(let hotel):
                self.info = hotel
            case .failure(let error):
                self.logger.error("HotelVM error: \(error)")
                break
            }
        }
    }
}
