//
//  Double+Formatter.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import Foundation

extension Double {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(for: self)!
    }
}
