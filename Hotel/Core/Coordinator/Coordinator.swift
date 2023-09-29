//
//  Coordinator.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

enum Page: String, Identifiable {
    case hotel, apartmentsList, booking, orderPaid
    
    var id: String {
        self.rawValue
    }
}

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        if path.count > 0 {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = .init()
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .hotel:
            HotelAssembly.getModule()
        case .apartmentsList:
            ApartmentsListAssembly.getModule()
        case .booking:
            BookingAssembly.getModule()
        case .orderPaid:
            OrderPaidAssembly.getModule()
        }
    }
}

