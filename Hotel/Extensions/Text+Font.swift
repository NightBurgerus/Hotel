//
//  Text+Font.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

enum CustomFont {
    case sfProDisplay(SFProDisplay)
}

extension Text {
    func customFont(_ font: CustomFont, ofSize size: CGFloat) -> Text {
        switch font {
        case .sfProDisplay(let sFProDisplay):
            return self.font(.custom(sFProDisplay.rawValue, size: size))
        }
    }
    
    // MARK: SF Pro Display
    func sfProDisplayFont(ofWeight weight: Double, size: CGFloat, isItalic: Bool = false) -> Text {
        var fontName = "SFProDisplay-"
        switch weight {
        case 100: fontName += "Ultralight"
        case 200: fontName += "Thin"
        case 300: fontName += "Light"
        case 500: fontName += "Medium"
        case 600: fontName += "Semibold"
        case 700: fontName += "Bold"
        case 800: fontName += "Heavy"
        case 900: fontName += "Black"
        default: fontName += ""
        }
        
        if isItalic { fontName += "Italic" }
        
        return self.font(.custom(fontName, size: size))
    }
}
