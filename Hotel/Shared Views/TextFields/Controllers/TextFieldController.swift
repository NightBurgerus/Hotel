//
//  TextFieldController.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

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
        textField.keyboardType = .emailAddress
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        onTextChange(textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        firstResponder = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        firstResponder = false
    }

}
