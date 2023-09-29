//
//  HotelAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class HotelAssembly {
    static func getModule() -> some View {
        return HotelScreen().navigationBarBackButtonHidden(true)
    }
}


