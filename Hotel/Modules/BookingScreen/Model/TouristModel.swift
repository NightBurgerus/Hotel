//
//  TouristModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

struct Tourist: Identifiable {
    let id = UUID()
    var name: String
    var lastName: String
    var dateOfBirth: String
    var citizenship: String
    var passportNumber: String
    var dateOfPassport: String
    
    init() {
        name = ""
        lastName = ""
        dateOfBirth = ""
        citizenship = ""
        passportNumber = ""
        dateOfPassport = ""
    }
}
