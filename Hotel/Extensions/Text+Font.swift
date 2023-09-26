//
//  Text+Font.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

// MARK: SF Pro Display
enum SFProDisplay: String {
    // General
    case thin = "SFProDisplay-Thin"
    case bold = "SFProDisplay-Bold"
    case black = "SFProDisplay-Black"
    case heavy = "SFProDisplay-Heavy"
    case light = "SFProDisplay-Light"
    case medium = "SFProDisplay-Medium"
    case regular = "SFProDisplay-Regular"
    case semibold = "SFProDisplay-Semibold"
    case ultralight = "SFProDisplay-Ultralight"
    
    // Italic
    case thinItalic = "SFProDisplay-ThinItalic"
    case boldItalic = "SFProDisplay-boldItalic"
    case blackItalic = "SFProDisplay-BlackItalic"
    case heavyItalic = "SFProDisplay-HeavyItalic"
    case lightItalic = "SFProDisplay-LightItalic"
    case mediumItalic = "SFProDisplay-MediumItalic"
    case regularItalic = "SFProDisplay-RegularItalic"
    case semiboldItalic = "SFProDisplay-SemiboldItalic"
    case ultralightItalic = "SFProDisplay-UltralightItalic"
}

enum CustomFont {
    case sfProDisplay(SFProDisplay)
}

extension Text {
    func customFont(_ font: CustomFont, ofSize size: CGFloat) -> some View {
        switch font {
        case .sfProDisplay(let sFProDisplay):
            return self.font(.custom(sFProDisplay.rawValue, size: size))
        }
    }
}
