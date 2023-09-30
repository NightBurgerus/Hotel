//
//  BackButton.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

/// __Кнопка назад__

struct BackButton: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        Button {
            coordinator.pop()
        } label: {
            R.Images.ArrowLeftImage
        }
    }
}
