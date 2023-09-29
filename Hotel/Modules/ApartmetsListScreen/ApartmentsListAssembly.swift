//
//  ApartmentsListAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class ApartmentsListAssembly {
    static func getModule() -> some View {
        let repository = HotelRepository()
        let viewModel = ApartmentsListViewModel(repository: repository)
        return ApartmensListScreen(viewModel: viewModel).navigationBarBackButtonHidden(true)
    }
}

