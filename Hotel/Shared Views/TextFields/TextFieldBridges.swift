//
//  PhoneTextField.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct DateTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = MaskedTextFieldController
    var currentText: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    var onTextChange: (String) -> ()
    
    func makeUIViewController(context: Context) -> MaskedTextFieldController {
//        return DateTextFieldController(currentDate: currentText, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
        return MaskedTextFieldController(configuration: .date, currentText: currentText, firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: onTextChange)
    }
    
    func updateUIViewController(_ uiViewController: MaskedTextFieldController, context: Context) {
    }
}

struct PhoneTextFieldBridge: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhoneTextFieldController
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var placeholder: String = ""
    
    func makeUIViewController(context: Context) -> PhoneTextFieldController {
        return PhoneTextFieldController(firstResponder: $isFirstResponder, placeholder: placeholder, onTextChange: { text = $0 })
    }
    
    func updateUIViewController(_ uiViewController: PhoneTextFieldController, context: Context) {
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

class TextFieldController: UIViewController, UITextFieldDelegate {
    @Binding private var firstResponder: Bool
    private let textField = UITextField()
    private var currentText = ""
    private var placeholder = ""
    private var onTextChange: (String) -> ()
    
    init(currentText: String, firstResponder: Binding<Bool>, placeholder: String, onTextChange: @escaping(String) -> ()) {
        self._firstResponder = firstResponder
        self.placeholder = placeholder
        self.onTextChange = onTextChange
        self.currentText = currentText
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
        textField.text = currentText
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        onTextChange(textField.text ?? "")
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

struct MaskedTFConfiguration {
    let mask: String
    let separator: String
    let keyboardType: UIKeyboardType
    let cursorIsHidden: Bool = false
    var countSeparators: Int {
        return mask.filter({ String($0) == separator }).count
    }
    
    static let phone: MaskedTFConfiguration = {
        return MaskedTFConfiguration(mask: "+7 (***) ***-**-**", separator: "*", keyboardType: .numberPad)
    }()
    
    static let date: MaskedTFConfiguration = {
        return MaskedTFConfiguration(mask: "__.__.____", separator: "_", keyboardType: .numberPad)
    }()
}

final class MaskedTextFieldController: TextFieldController {
    @Binding var firstResponder: Bool
    private let textField = UITextField()
    private var configuration: MaskedTFConfiguration
    private var currentText = ""
    private var placeholder = ""
    private var onTextChange: (String) -> ()
    
    init(configuration: MaskedTFConfiguration, currentText: String, firstResponder: Binding<Bool>, placeholder: String, onTextChange: @escaping(String) -> ()) {
        self._firstResponder = firstResponder
        self.configuration = configuration
        self.placeholder = placeholder
        self.currentText = currentText
        self.onTextChange = onTextChange
        super.init(currentText: "", firstResponder: firstResponder, placeholder: placeholder, onTextChange: onTextChange)
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
        textField.placeholder = placeholder
        textField.textColor = UIColor(R.Colors.lightBlack)
        if configuration.cursorIsHidden {
            textField.tintColor = UIColor.clear
        }
        textField.keyboardType = configuration.keyboardType
        currentText = configuration.mask
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
//        if string.isEmpty && currentPhone.count > 0 {
//            guard let index = phoneMask.unicodeScalars.lastIndex(where: { char in CharacterSet.decimalDigits.contains(char) }) else { return false }
//            phoneMask.replaceSubrange(index...index, with: "*")
//            currentPhone.removeLast()
//            textField.text = phoneMask
//            onTextChange(textField.text ?? "")
//            return false
//        }
        if !string.isEmpty {
            guard let index = currentText.firstIndex(where: { String($0) == configuration.separator}) else { return false }
            currentText.replaceSubrange(index...index, with: string)
            textField.text = currentText
            onTextChange(textField.text ?? "")
        }
        return false
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        textField.text = currentText
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if currentText.isEmpty {
            textField.text = ""
        }
    }
}

final class PhoneTextFieldController: TextFieldController {
    @Binding var firstResponder: Bool
    private let textField = UITextField()
    private var phoneMask = "+7 (***) ***-**-**"
    private var currentPhone = ""
    private var placeholder = ""
    private var onTextChange: (String) -> ()
    
    init(firstResponder: Binding<Bool>, placeholder: String, onTextChange: @escaping(String) -> ()) {
        self._firstResponder = firstResponder
        self.placeholder = placeholder
        self.onTextChange = onTextChange
        super.init(currentText: "", firstResponder: firstResponder, placeholder: phoneMask, onTextChange: onTextChange)
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
    
    override func configureType() {
        textField.tintColor = UIColor.clear
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && currentPhone.count > 0 {
            guard let index = phoneMask.unicodeScalars.lastIndex(where: { char in CharacterSet.decimalDigits.contains(char) }) else { return false }
            phoneMask.replaceSubrange(index...index, with: "*")
            currentPhone.removeLast()
            textField.text = phoneMask
            onTextChange(textField.text ?? "")
            return false
        }
        if currentPhone.count < 10 && !string.isEmpty {
            currentPhone.append(string)
            guard let index = phoneMask.firstIndex(of: "*") else { return false }
            phoneMask.replaceSubrange(index...index, with: string)
            textField.text = phoneMask
            onTextChange(textField.text ?? "")
        }
        return false
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        textField.text = phoneMask
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if currentPhone.isEmpty {
            textField.text = ""
        }
    }
}

final class DateTextFieldController: TextFieldController {
    @Binding var firstResponder: Bool
    private let textField = UITextField()
    private var dateMask = "__.__.____"
    private var currentDate = ""
    private var placeholder = ""
    private var onTextChange: (String) -> ()
    
    init(currentDate: String, firstResponder: Binding<Bool>, placeholder: String, onTextChange: @escaping(String) -> ()) {
        self._firstResponder = firstResponder
        self.placeholder = placeholder
        self.currentDate = currentDate
        self.onTextChange = onTextChange
        super.init(currentText: "", firstResponder: firstResponder, placeholder: dateMask, onTextChange: onTextChange)
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
        textField.text = currentDate
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
    
    override func configureType() {
        textField.tintColor = UIColor.clear
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty && currentDate.count > 0 {
            guard let index = dateMask.unicodeScalars.lastIndex(where: { char in CharacterSet.decimalDigits.contains(char) }) else { return false }
            dateMask.replaceSubrange(index...index, with: "_")
            currentDate.removeLast()
            textField.text = dateMask
            onTextChange(textField.text ?? "")
            return false
        }
        if currentDate.count < 8 && !string.isEmpty {
            currentDate.append(string)
            guard let index = dateMask.firstIndex(of: "_") else { return false }
            dateMask.replaceSubrange(index...index, with: string)
            textField.text = dateMask
            onTextChange(textField.text ?? "")
        }
        return false
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        textField.text = dateMask
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if currentDate.isEmpty {
            textField.text = ""
            onTextChange("")
        }
    }
}
