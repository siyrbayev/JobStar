//
//  View++.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import Foundation
import SwiftUI

extension View {
    
#if canImport(UIKit)
    /// Hide the keyboard from View
    ///
    /// Example with onTapGesture;
    /// ```
    ///  Text("hide keyboard")
    ///      .onTapGesture {
    ///          hideKeyboard()
    ///       }
    /// ```
    /// Example with Button action:
    /// ```
    ///  Button {
    ///      .hideKeyboard()
    ///  } label: {
    ///      Text("hide keyboard")
    ///  }
    /// ```
    ///
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
#endif
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    @ViewBuilder func isBlur(_ isBlur: Bool, radius: CGFloat) -> some View {
        if isBlur {
            self.blur(radius: radius)
        } else {
            self
        }
    }
}
