//
//  BookingAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class BookingAssembly {
    static func getModule() -> some View {
        let repository = HotelRepository()
        let viewModel = BookingViewModel(repository: repository)
        return BookingScreen(viewModel: viewModel).navigationBarBackButtonHidden(true)
    }
}

