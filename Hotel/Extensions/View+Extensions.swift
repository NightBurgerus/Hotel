//
//  View+Extensions.swift
//  Hotel
//
//  Created by Чебупелина on 27.09.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
