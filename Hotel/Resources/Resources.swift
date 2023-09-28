//
//  Resources.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct R {
    private init() {}
    
    struct Strings {
        private init() {}
        
        struct Hotel {
            private init() {}
            
            static let title = "Отель"
            static let aboutHotel = "Об отеле"
            static let conveniences = "Удобства"
            static let conveniencesSubtitle = "Самое необходимое"
            
            static let included = "Что включено"
            static let includedSubtitle = "Самое необходимое"
            
            static let notIncluded = "Что не включено"
            static let notIncludedSubtitle = "Самое необходимое"
            
            static let toApartmentChoose = "К выбору номера"
        }
        
        struct ApartmentsList {
            private init() {}
            
            static let title = "Steigenberger Makadi"
            static let moreInfo = "Подробнее о номере"
            static let chooseApartment = "Выбрать номер"
        }
        
        struct Booking {
            private init() {}
            
            static let title = "Бронирование"
            static let departure = "Вылет из"
            static let arrivalCountry = "Страна, город"
            static let tourDates = "Даты"
            static let numberOfNights = "Кол-во ночей"
            static let hotel = "Отель"
            static let room = "Номер"
            static let nutrition = "Питание"
            
            static let buyerInfo = "Информация о покупателе"
            static let dataDontTransfer = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
            
        }
    }
    
    struct Images {
        private init() {}
        
        static let StarImage = Image("star")
        static let ArrowRightImage = Image("rightArrow")
        static let ArrowLeftImage  = Image("leftArrow")
        static let HappyEmoji = Image("happyEmoji")
        static let TickSquare = Image("tickSquare")
        static let CloseSquare = Image("closeSquare")
        static let AddButton = Image("addButton")
    }
    
    struct Colors {
        private init() {}
        /// red: 255,  green: 168, blue: 0, alpha 1
        static let orange       = Color("Orange")
        /// red: 255, green: 199, blue: 0, alpha: 0.2
        static let lightOrange  = Color("lightOrange")
        /// red: 13, green: 144, blue: 255, alpha: 1
        static let blue         = Color("blue")
        /// red: 130, green: 135, blue:  150, alpha: 1
        static let gray         = Color("gray")
        /// red: 251, green: 251, blue: 252, alpha: 1
        static let lightGray    = Color("lightGray")
        /// red: 44, green: 48, blue: 53, alpha: 1
        static let darkGray     = Color("darkGray")
        /// red: 0.91, green: 0.91, blue: 0.93, alpha: 1
        static let gray232      = Color("gray232")
        static let gray246      = Color("gray246")
        static let lightBlack   = Color("lightBlack")
        static let gray066      = Color("gray066")
        static let gray096      = Color("gray096")
    }
}
