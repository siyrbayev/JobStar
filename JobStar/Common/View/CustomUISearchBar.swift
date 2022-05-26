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
    
    func makeUIView(context: UIViewRepresentableContext<CustomUISearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        
        
        searchBar.layer.borderColor = Color.secondary.cgColor
        searchBar.tintColor = UIColor(Color.tx_pr)
        
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomUISearchBar>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> CustomUISearchBar.Coordinator {
        return Coordinator(text: $text)
    }
}

extension CustomUISearchBar {
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
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
