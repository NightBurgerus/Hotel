//
//  TouristBlockView.swift
//  Hotel
//
//  Created by Чебупелина on 30.09.2023.
//

import SwiftUI

struct TouristBlock: View {
    let number: Int
    @Binding var tourist: TouristFieldModel
    @State private var isOpen = true
    
    var body: some View {
        BlockView {
            VStack {
                title
                
                if isOpen {
                    GeneralTextField(title: R.Strings.Booking.name, placeholder: R.Strings.Booking.name, text: $tourist.value.name, error: $tourist.nameError, isFirstResponder: $tourist.nameIsFirstResponder)
                    
                    GeneralTextField(title: R.Strings.Booking.lastName, placeholder: R.Strings.Booking.lastName, text: $tourist.value.lastName, error: $tourist.lastNameError, isFirstResponder: $tourist.lastNameIsFirstResponder)
                    
                    DateTextField(title: R.Strings.Booking.dateOfBirth, placeholder: R.Strings.Booking.dateOfBirth, text: $tourist.value.dateOfBirth, error: $tourist.dateOfBirthError)
                    
                    GeneralTextField(title: R.Strings.Booking.citizenship, placeholder: R.Strings.Booking.citizenship, text: $tourist.value.citizenship, error: $tourist.citizenshipError, isFirstResponder: $tourist.citizenshipIsFirstResponder)
                    
                    PassportTextField(title: R.Strings.Booking.passportNumber, placeholder: R.Strings.Booking.passportNumber, text: $tourist.value.passportNumber, error: $tourist.passportError)
                    
                    DateTextField(title: R.Strings.Booking.dateOfPassport, placeholder: R.Strings.Booking.dateOfPassport, text: $tourist.value.dateOfPassport, error: $tourist.dateOfPassportError)
                }
            }
            .padding(16)
        }
    }
    
    private var title: some View {
        HStack {
            Text(String.sequenceNumber(number) + " турист")
                .customFont(.sfProDisplay(.medium), ofSize: 22)
                .foregroundColor(.black)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(R.Colors.blue.opacity(0.1))
                
                R.Images
                    .ArrowRightImage
                    .rotationEffect(.degrees(isOpen ? 90 : -90))
            }
            .frame(width: 32, height: 32)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    self.isOpen.toggle()
                }
            }
        }
    }
}
