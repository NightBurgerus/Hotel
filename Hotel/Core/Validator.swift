//
//  Validator.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation
import OSLog

/// __Валидация телефона и почты__

final class Validator {
    private let logger = Logger()
    
    func isValidPhone(_ phone: String) -> Bool {
        let clearPhone = phone.unicodeScalars.filter({ CharacterSet.decimalDigits.contains($0) }).map({ String($0) }).reduce("", +)
        return clearPhone.count == 11
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let pattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}$"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            return regex.matches(in: email, range: NSRange(location: 0, length: email.count)).count > 0
        } catch {
            return false
        }
    }
}
