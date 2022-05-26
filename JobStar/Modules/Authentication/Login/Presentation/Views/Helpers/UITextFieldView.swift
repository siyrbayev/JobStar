//
//  UITextFieldView.swift
//  JobStar
//
//  Created by siyrbayev on 10.04.2022.
//

import Foundation
import SwiftUI

struct CustomUITextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var shouldReturn: () -> Void
        
        var didBecomeFirstResponder = false
        
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
    
    var placeHolder: String = ""
    @Binding var text: String
    var isFirstResponder: Bool = false
    var borderStyle: UITextField.BorderStyle = .none
    var shouldReturn: () -> Void = {}
    
    func makeUIView(context: UIViewRepresentableContext<CustomUITextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeHolder
        textField.borderStyle = borderStyle
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
        return textField
    }
    
    func makeCoordinator() -> CustomUITextField.Coordinator {
        return Coordinator(text: $text, shouldReturn: shouldReturn)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomUITextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
