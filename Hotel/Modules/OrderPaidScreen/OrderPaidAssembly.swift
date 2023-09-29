//
//  OrderPaidAssembly.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

final class OrderPaidAssembly {
    static func getModule() -> some View {
        return OrderPaidScreen().navigationBarBackButtonHidden(true)
    }
}
