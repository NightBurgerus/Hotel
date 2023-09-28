//
//  PhoneTextField.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct PhoteTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhoneTextFieldController
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    
    func makeUIViewController(context: Context) -> PhoneTextFieldController {
        return PhoneTextFieldController(text: $text, firstResponder: $isFirstResponder)
    }
    
    func updateUIViewController(_ uiViewController: PhoneTextFieldController, context: Context) {
    }
}

struct TextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = TextFieldController
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    
    func makeUIViewController(context: Context) -> TextFieldController {
        return TextFieldController(text: $text, firstResponder: $isFirstResponder, placeholder: placeholder)
    }
    
    func updateUIViewController(_ uiViewController: TextFieldController, context: Context) {
    }
}

class TextFieldController: UIViewController, UITextFieldDelegate {
    @Binding private var firstResponder: Bool
    @Binding private var text: String
    private let textField = UITextField()
    private var currentText = ""
    private var placeholder = ""
    
    init(text: Binding<String>, firstResponder: Binding<Bool>, placeholder: String) {
        self._firstResponder = firstResponder
        self._text = text
        self.placeholder = placeholder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    fileprivate func configureView() {
        textField.delegate = self
        configureType()
        textField.placeholder = placeholder
        textField.textColor = UIColor(R.Colors.lightBlack)
        view.addSubview(textField)
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureType() {
        textField.keyboardType = .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.firstResponder = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.firstResponder = false
    }

}

final class PhoneTextFieldController: TextFieldController {
    @Binding var firstResponder: Bool
    @Binding var text: String
    private let textField = UITextField()
    private var phoneMask = "+7 (***) ***-**-**"
    private var currentPhone = ""
    
    init(text: Binding<String>, firstResponder: Binding<Bool>) {
        self._firstResponder = firstResponder
        self._text = text
        super.init(text: text, firstResponder: firstResponder, placeholder: phoneMask)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func configureView() {
        textField.delegate = self
        configureType()
        textField.placeholder = phoneMask
        textField.textColor = UIColor(R.Colors.lightBlack)
        view.addSubview(textField)

        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureType() {
        textField.tintColor = UIColor.clear
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && currentPhone.count > 0 {
            guard let index = phoneMask.unicodeScalars.lastIndex(where: { char in CharacterSet.decimalDigits.contains(char) }) else { return false }
            phoneMask.replaceSubrange(index...index, with: "*")
            currentPhone.removeLast()
            textField.text = phoneMask
            text = phoneMask
            return false
        }
        if currentPhone.count < 10 && !string.isEmpty {
            currentPhone.append(string)
            guard let index = phoneMask.firstIndex(of: "*") else { return false }
            phoneMask.replaceSubrange(index...index, with: string)
            textField.text = phoneMask
            text = phoneMask
        }
        return false
    }

}
