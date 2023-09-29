//
//  BookingAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class BookingAssembly {
    static func getModule() -> some View {
        return BookingScreen().navigationBarBackButtonHidden(true)
    }
}

