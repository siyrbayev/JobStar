//
//  UITextFieldView.swift
//  JobStar
//
//  Created by siyrbayev on 10.04.2022.
//

import Foundation
import SwiftUI

struct CustomUITextField: UIViewRepresentable {
    var placeHolder: String = ""
    @Binding var text: String
    
    var isFirstResponder: Bool = false
    var isToolBarShown: Bool = true
    var viewMode: UITextField.ViewMode = .whileEditing
    var borderStyle: UITextField.BorderStyle = .none
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var autocorrectionType: UITextAutocorrectionType = .default
    var shouldReturn: () -> Void = {}
    
    // MARK: - Make UIView
    
    func makeUIView(context: UIViewRepresentableContext<CustomUITextField>) -> UITextField {
        
        let textField = UITextField(frame: .zero)
        
        textField.delegate = context.coordinator
        textField.placeholder = placeHolder
        textField.borderStyle = borderStyle
        textField.clearButtonMode = viewMode
        textField.autocapitalizationType = autocapitalizationType
        textField.autocorrectionType  = autocorrectionType
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        if isToolBarShown {
            configureToolBarItems(textField)
        }
        
        return textField
    }
    
    // MARK: - Make Coordinator
    
    func makeCoordinator() -> CustomUITextField.Coordinator {
        return Coordinator(text: $text, shouldReturn: shouldReturn)
    }
    
    // MARK: - Update View
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomUITextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var shouldReturn: () -> Void
        var didBecomeFirstResponder = false
        
        // MARK: - Init
        
        init(text: Binding<String>, shouldReturn: @escaping () -> Void) {
            _text = text
            self.shouldReturn = shouldReturn
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            shouldReturn()
            return true
        }
        
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            text = ""
            return true
        }
    }
}

// MARK: - Private func

private extension CustomUITextField {
    
    func configureToolBarItems(_ textField: UITextField) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
        
        toolBar.setItems([spacer, doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
}

// MARK: - Additional Buttons

extension UITextField {
    @objc func doneButtonTapped(button: UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}
