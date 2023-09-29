//
//  TouristFieldModel.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

final class TouristFieldModel: ObservableObject {
    @Published var value: Tourist
    @Published var nameError = false
    @Published var lastNameError = false
    @Published var dateOfBirthError = false
    @Published var citizenshipError = false
    
    var hasAnyEmptyField: Bool {
        return nameError || lastNameError || dateOfBirthError || citizenshipError
    }
    
    init(tourist: Tourist) {
        self.value = tourist
    }
    
    func checkFields() {
        nameError = value.name.isEmpty
        lastNameError = value.lastName.isEmpty
        dateOfBirthError = value.dateOfBirth.isEmpty
        citizenshipError = value.citizenship.isEmpty
    }
}
