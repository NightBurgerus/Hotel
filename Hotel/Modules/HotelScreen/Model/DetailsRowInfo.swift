//
//  DetailsRowInfo.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

struct DetailsRowInfo {
    let image: Image
    let title: String
    let subtitle: String
    
    static let conveniences = DetailsRowInfo(image: R.Images.HappyEmoji, title: R.Strings.Hotel.conveniences, subtitle: R.Strings.Hotel.conveniencesSubtitle)
    
    static let included = DetailsRowInfo(image: R.Images.TickSquare, title: R.Strings.Hotel.included, subtitle: R.Strings.Hotel.includedSubtitle)
    
    static let notIncluded = DetailsRowInfo(image: R.Images.CloseSquare, title: R.Strings.Hotel.notIncluded, subtitle: R.Strings.Hotel.notIncludedSubtitle)
}
