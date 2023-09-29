//
//  HotelViewModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

protocol HotelViewModelProtocol: AnyObject, ObservableObject {
    var info: Hotel? { get }
    func loadData()
}

final class HotelViewModel: HotelViewModelProtocol {
    @Published private(set) var info: Hotel? = nil
    private let repository: HotelRepositoryProtocol
    
    init(repository: HotelRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadData() {
        repository.getHotel { response in
            switch response {
            case .success(let hotel):
                self.info = hotel
            case .failure(let error):
                print("~ error: ", error)
                break
            }
        }
    }
}