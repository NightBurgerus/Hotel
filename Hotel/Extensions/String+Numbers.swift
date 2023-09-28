//
//  String+Numbers.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import Foundation

extension String {
    static var number1: String { "Первый" }
    static var number2: String { "Второй" }
    static var number3: String { "Третий" }
    static var number4: String { "Четвёртый" }
    static var number5: String { "Пятый" }
    static var number6: String { "Шестой" }
    static var number7: String { "Седьмой" }
    static var number8: String { "Восьмой" }
    static var number9: String { "Девятый" }
    static var number10: String { "Десятый" }
    static var number11: String { "Одинадцатый" }
    static var number12: String { "Двенадцатый" }
    static var number13: String { "Тринадцатый" }
    static var number14: String { "Четырнадцатый" }
    static var number15: String { "Пятнадцатый" }
    static var number16: String { "Шестнадцатый" }
    static var number17: String { "Семнадцатый" }
    static var number18: String { "Восемнадцацый" }
    static var number19: String { "Девятнадцатый" }
    static var number20: String { "Двадцатый" }
    static var number20n: String { "Двадцать" }
    static var number30: String { "Тридцатый" }
    static var number30n: String { "Тридцать" }
    static var number40: String { "Сороковой" }
    static var number40n: String { "Сорок" }
    static var number50: String { "Пятидесятый" }
    static var number50n: String { "Пятьдесят" }
    static var number60: String { "Шестидесятый" }
    static var number60n: String { "Шестьдесят" }
    static var number70: String { "Семидесятый" }
    static var number70n: String { "Семдесят" }
    static var number80: String { "Восьмидесятый" }
    static var number80n: String { "Весемдесят" }
    static var number90: String { "Девяностый" }
    static var number90n: String { "Девяносто" }
    static var number100: String { "Сотый" }
    static var number100n: String { "Сто" }
    
    static var first20: [String] {
        [
            number1,
            number2,
            number3,
            number4,
            number5,
            number6,
            number7,
            number8,
            number9,
            number10,
            number11,
            number12,
            number13,
            number14,
            number15,
            number16,
            number17,
            number18,
            number19,
            number20
        ]
    }
    
    static func sequenceNumber(_ number: Int) -> String {
        if number < 1 { return String(number) }
        if number < 21 { return first20[number - 1] }
        return String(number)
    }
}
