//
//  HotelAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class HotelAssembly {
    static func getModule() -> some View {
        let repository = HotelRepository()
        let viewModel = HotelViewModel(repository: repository)
        return HotelScreen(viewModel: viewModel).navigationBarBackButtonHidden(true)
    }
}


