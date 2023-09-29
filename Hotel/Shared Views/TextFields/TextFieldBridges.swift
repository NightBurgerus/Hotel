//
//  PhoneTextField.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct PassportTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = MaskedTextFieldController
    var currentText: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    var onTextChange: (String) -> ()
    
    func makeUIViewController(context: Context) -> MaskedTextFieldController {
        return MaskedTextFieldController(configuration: .passportNumber, currentText: currentText, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
    }
    
    func updateUIViewController(_ uiViewController: MaskedTextFieldController, context: Context) {
    }
}

struct DateTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = MaskedTextFieldController
    var currentText: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    var onTextChange: (String) -> ()
    
    func makeUIViewController(context: Context) -> MaskedTextFieldController {
        return MaskedTextFieldController(configuration: .date, currentText: currentText, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
    }
    
    func updateUIViewController(_ uiViewController: MaskedTextFieldController, context: Context) {
    }
}

struct PhoneTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = MaskedTextFieldController
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    var onTextChange: (String) -> ()
    
    func makeUIViewController(context: Context) -> MaskedTextFieldController {
        return MaskedTextFieldController(configuration: .phone, currentText: text, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
    }
    
    func updateUIViewController(_ uiViewController: MaskedTextFieldController, context: Context) {
    }
}

struct TextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = TextFieldController
    var currentText: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    var onTextChange: (String) -> ()
    
    func makeUIViewController(context: Context) -> TextFieldController {
        return TextFieldController(currentText: currentText, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
    }
    
    func updateUIViewController(_ uiViewController: TextFieldController, context: Context) {
    }
}
