//
//  ContentView.swift
//  JobStar
//
//  Created by siyrbayev on 17.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - AppStorage

    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    @AppStorage("isFirstLaunch")
    private var isFirstLaunch: Bool = true
    
    // MARK: - Body
    
    var body: some View {
        if isAuthenticated {
            TabBarView()
        } else {
            if isFirstLaunch {
                FirstLaunchView()
                    .navigationViewStyle(StackNavigationViewStyle())
            } else {
                LoginView()
                    .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
