//
//  FirstLaunchView.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import SwiftUI

// MARK: - Previews

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}

struct FirstLaunchView: View {
    
    // MARK: - State
    
    @State private var isLoginViewPresents: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    NavigationLink {
                        RegistrationView()
                    } label: {
                        Text("Create new account")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.vertical, 18)
                            .padding(.horizontal, 40)
                            .background(
                                Color.accent_pr
                                    .cornerRadius(12)
                            )
                    }
                    .padding()
                    
                    Button(action: presentLoginView) {
                        Text("Log in")
                            .foregroundColor(.lb_pr)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding()
                }
                .padding(.bottom)
            }
            .fullScreenCover(isPresented: $isLoginViewPresents) {
                LoginView()
            }
        }
    }
}

private extension FirstLaunchView {
    
    func presentLoginView() {
        isLoginViewPresents.toggle()
    }
}

