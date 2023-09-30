//
//  MaskedTextFieldController.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

enum MaskType {
    case phone
    case date
    case passportNumber
}

struct MaskedTFConfiguration {
    let type: MaskType
    let mask: String
    let separator: String
    let keyboardType: UIKeyboardType
    let cursorIsHidden: Bool
    var countSeparators: Int {
        return mask.filter({ String($0) == separator }).count
    }
    
    static let phone: MaskedTFConfiguration = {
        return MaskedTFConfiguration(type: .phone, mask: "+7 (***) ***-**-**", separator: "*", keyboardType: .numberPad, cursorIsHidden: true)
    }()
    
    static let date: MaskedTFConfiguration = {
        return MaskedTFConfiguration(type: .date, mask: "__.__.____", separator: "_", keyboardType: .numberPad, cursorIsHidden: true)
    }()
    
    static let passportNumber: MaskedTFConfiguration = {
        return MaskedTFConfiguration(type: .passportNumber, mask: "__ _______", separator: "_", keyboardType: .numberPad, cursorIsHidden: true)
    }()
}

final class MaskedTextFieldController: TextFieldController {
    @Binding var firstResponder: Bool
    private let textField = UITextField()
    private var configuration: MaskedTFConfiguration
    private var currentText = ""
    private var placeholder = ""
    private var onTextChange: (String) -> ()
    private var currentDigitsCount: Int {
        currentText.unicodeScalars.filter({ CharacterSet.decimalDigits.contains($0) }).count
    }
    
    init(configuration: MaskedTFConfiguration, currentText: String, firstResponder: Binding<Bool>, placeholder: String, onTextChange: @escaping(String) -> ()) {
        self._firstResponder = firstResponder
        self.configuration = configuration
        self.placeholder = placeholder
        self.currentText = currentText
        self.onTextChange = onTextChange
        super.init(currentText: "", firstResponder: firstResponder, placeholder: "", onTextChange: onTextChange)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        textField.delegate = self
        textField.placeholder = placeholder
        textField.textColor = UIColor(R.Colors.lightBlack)
        if configuration.cursorIsHidden {
            textField.tintColor = UIColor.clear
        }
        textField.keyboardType = configuration.keyboardType
        textField.text = currentText
        view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Стирание символа
        if string.isEmpty && (textField.text ?? "").count > 0 {
            if currentDigitsCount == 1 && configuration.type == MaskedTFConfiguration.phone.type { return false }
            
            guard let index = textField.text!.unicodeScalars.lastIndex(where: { char in CharacterSet.decimalDigits.contains(char) }) else { return false }
            textField.text!.replaceSubrange(index...index, with: configuration.separator)
            currentText = textField.text!
            if textField.text!.count > 0 {
                textField.placeholder = ""
            }
            onTextChange(textField.text ?? "")
            return false
        }
        // Добавление символа
        if !string.isEmpty {
            guard let index = (textField.text ?? "").firstIndex(where: { String($0) == configuration.separator }) else { return false }
            textField.text!.replaceSubrange(index...index, with: string)
            currentText = textField.text!
            onTextChange(textField.text ?? "")
        }
        return false
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        if currentText.isEmpty {
            textField.text = configuration.mask
        } else {
            textField.text = currentText
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        
        if configuration.type == .phone {
            if currentText.isEmpty || currentText.filter({ String($0) == configuration.separator }).count == 10 {
                textField.text = ""
                textField.placeholder = placeholder
                onTextChange("")
            }
            return
        }
        
        // Если данных нет
        if currentText.filter({ String($0) == configuration.separator }).count == configuration.countSeparators{
            textField.text = ""
            textField.placeholder = placeholder
            onTextChange("")
        }
    }
}
