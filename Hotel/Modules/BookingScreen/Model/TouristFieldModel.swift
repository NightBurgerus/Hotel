//
//  TouristFieldModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

final class TouristFieldModel: ObservableObject {
    @Published var value: Tourist
    @Published var nameIsFirstResponder = false
    @Published var lastNameIsFirstResponder = false
    @Published var citizenshipIsFirstResponder = false
    @Published var nameError = false
    @Published var lastNameError = false
    @Published var dateOfBirthError = false
    @Published var citizenshipError = false
    @Published var passportError = false
    @Published var dateOfPassportError = false
    
    var hasAnyEmptyField: Bool {
        return nameError || lastNameError || dateOfBirthError || citizenshipError || passportError || dateOfPassportError
    }
    
    init(tourist: Tourist) {
        self.value = tourist
    }
    
    func checkFields() {
        nameError = value.name.isEmpty
        lastNameError = value.lastName.isEmpty
        dateOfBirthError = value.dateOfBirth.filter({ String($0) == "_" }).count != 0 || value.dateOfBirth.isEmpty
        citizenshipError = value.citizenship.isEmpty
        passportError = value.passportNumber.filter({ String($0) == "_" }).count != 0 || value.passportNumber.isEmpty
        dateOfPassportError = value.dateOfPassport.filter({ String($0) == "_" }).count != 0 || value.dateOfPassport.isEmpty
    }
}
