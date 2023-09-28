//
//  Double+Formatter.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import Foundation

extension Double {
    var formatted: String {
        if self == Double(Int(self)) {
            return "\(Int(self))"
        }
        return String(format: "%.1f", self)
    }
}
