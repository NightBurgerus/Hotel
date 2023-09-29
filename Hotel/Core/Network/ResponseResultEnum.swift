//
//  ResponseResultEnum.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error)
}
