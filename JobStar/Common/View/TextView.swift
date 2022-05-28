//
//  TextView.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
 
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
    var autocorrectionType: UITextAutocorrectionType = .default
    var backgroundColor: UIColor = .clear
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.autocorrectionType = autocorrectionType
        textView.backgroundColor = backgroundColor
        
        configureToolBarItems(textView)
        
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
     
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}

// MARK: - Private func

private extension TextView {
    
    func configureToolBarItems(_ textView: UITextView) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textView.frame.size.width, height: 44))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textView.doneButtonTapped(button:)))
        
        toolBar.setItems([spacer, doneButton], animated: true)
        textView.inputAccessoryView = toolBar
    }
}

// MARK: - Additional Buttons

extension UITextView {
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}
