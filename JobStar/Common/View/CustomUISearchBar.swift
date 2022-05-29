//
//  CustomUISearchBar.swift
//  JobStar
//
//  Created by siyrbayev on 03.05.2022.
//

import Foundation
import SwiftUI

struct CustomUISearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var isFirstResponder: Bool = false
    var searchBarStyle: UISearchBar.Style = .minimal
    
    var onCancelButtonClicked: () -> Void = {}
    
    func makeUIView(context: UIViewRepresentableContext<CustomUISearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = searchBarStyle
        
        searchBar.layer.borderColor = Color.secondary.cgColor
        searchBar.tintColor = UIColor(Color.tx_pr)
        
        
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomUISearchBar>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    func makeCoordinator() -> CustomUISearchBar.Coordinator {
        return Coordinator(text: $text, onCancelButtonClicked: onCancelButtonClicked)
    }
}

extension CustomUISearchBar {
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        var didBecomeFirstResponder = false
        
        var onCancelButtonClicked: () -> Void = {}
        
        init(text: Binding<String>, onCancelButtonClicked: @escaping () -> Void) {
            _text = text
            self.onCancelButtonClicked = onCancelButtonClicked
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.resignFirstResponder()
            
            onCancelButtonClicked()
        }
    }
}

struct CustomUISearchBar2: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var isShown: Bool
    
    func makeUIView(context: UIViewRepresentableContext<CustomUISearchBar2>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.becomeFirstResponder()
        searchBar.layer.borderColor = Color.secondary.cgColor
        searchBar.tintColor = UIColor(Color.tx_pr)
        
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomUISearchBar2>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> CustomUISearchBar2.Coordinator {
        return Coordinator(text: $text, isShown: $isShown)
    }
}

extension CustomUISearchBar2 {
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        @Binding var isShown: Bool
        
        init(text: Binding<String>, isShown: Binding<Bool>) {
            _text = text
            _isShown = isShown
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isShown = false
            text = ""
            searchBar.showsCancelButton = false
            searchBar.resignFirstResponder()
        }
    }
}
