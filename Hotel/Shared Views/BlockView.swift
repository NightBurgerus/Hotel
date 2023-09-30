//
//  BlockView.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

/// __Вью-обёртка__
/// Добавляет закруглённый фон к контенту

struct BlockView<T: View>: View {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let roundedCorners: UIRectCorner
    let content: () -> T
    
    init(backgroundColor: Color = Color.white, cornerRadius: CGFloat = 12, roundedCorners: UIRectCorner = .allCorners, content: @escaping () -> T) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.roundedCorners = roundedCorners
        self.content = content
    }
    
    var body: some View {
        content()
            .background(
                Rectangle()
                    .fill(backgroundColor)
                    .cornerRadius(cornerRadius, corners: roundedCorners)
            )
    }
}
