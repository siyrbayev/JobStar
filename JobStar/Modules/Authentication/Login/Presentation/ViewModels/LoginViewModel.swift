//
//  LoginViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import Foundation
import SwiftUI

protocol LoginViewModelProtocol {
    func login()
}

class LoginViewModel: ObservableObject {
    
    private var userDefaults = UserDefaults.standard
    private let networkManager = AuthenticationNetworkManager.shared
    
    // MARK: - Published
    
    @Published var isLoading: Bool = false
    @Published var username: String = "" {
        didSet {
            usernamePrompt = ""
        }
    }
    @Published var password: String = "" {
        didSet {
            passwordPrompt = ""
        }
    }
    @Published var isAlertPresents: Bool = false
    @Published var errorMessagePrompt: String = ""
    @Published var usernamePrompt: String = ""
    @Published var passwordPrompt: String = ""
    
    var alert: () -> Alert = {
        return Alert(title: Text(""))
    }
    
    init() {
        
    }
    
    func onAppear() {
        
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func login() {
        isLoading = true
        
        withAnimation(.linear(duration: 0.1)) {
            self.errorMessagePrompt = ""
        }
        
        guard isUsernameAndPasswordEmpty() else {
            withAnimation {
                isLoading = false
            }
            return
        }
        
        var parameters: Parameters = [:]
        
        do {
            parameters = try DictionaryEncoder().encode(LoginRequestModel(username: username, password: password))
        } catch {
            print(error.localizedDescription)
            withAnimation {
                isLoading = false
            }
        }
        
        networkManager.login(parameters: parameters) { [weak self] successResponse, failResponse , error in
            defer {
                withAnimation {
                    self?.isLoading = false
                }
            }
            
            if let error = error {
                withAnimation(.linear(duration: 0.1)) {
                    self?.errorMessagePrompt = error
                }
                
                print(failResponse ?? "Faile Response")
            }
            
            guard let token = successResponse?.token, !token.isEmpty,
                  let username = self?.username, !username.isEmpty else {
                return
            }
            
            AppData.isAuthenticated = true
            AppData.username = username
            AppData.jsonWebToken = token
        }
    }
}

private extension LoginViewModel {
    
    func isUsernameAndPasswordEmpty() -> Bool {
        let isUsernameEmpty = username.isEmpty
        let isPasswordEmpty = password.isEmpty
            
        self.usernamePrompt = isUsernameEmpty ? "Login is required" : ""
        self.passwordPrompt = isPasswordEmpty ? "Password is required" : ""
        
        return !isUsernameEmpty && !isPasswordEmpty
    }
}
