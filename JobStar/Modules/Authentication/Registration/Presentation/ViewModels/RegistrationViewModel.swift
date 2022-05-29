//
//  RegistrationViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import Foundation
import SwiftUI

protocol RegistrationViewModelNetworkProtocol {
    
    func register()
}

struct PasswordPrompt: Identifiable {
    let id: UUID = UUID()
    let isValid: Bool
    let title: String
}

class RegistrationViewModel: ObservableObject {
    
    private let registerNetworkManager: RegistrationNetworkManagerProtocol!
    private let loginNetworkManager: LoginNetworkManagerProtocol!
    
    @Published var isRegistered: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var username: String = "" {
        didSet {
            if username.isEmpty {
                registerNetworkManager.cancel()
                isUsernameValid = false
                withAnimation {
                    usernamePrompt = ""
                }
            }
        }
    }
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var firstName: String = ""
    @Published var secondName: String = ""
    @Published var email: String = "" {
        didSet {
            validateEmail()
        }
    }
    
    @Published var usernamePrompt: String = ""
    @Published var passwordPrompt: [PasswordPrompt] = []
    @Published var confirmPasswordPrompt: [PasswordPrompt] = []
    @Published var firstNamePrompt: String = ""
    @Published var secondNamePrompt: String = ""
    @Published var emailPrompt: String = ""
    @Published var confirmEmailPrompt: String = ""
    
    
    @Published var isPasswordValid: Bool = false
    @Published var isConfirmPasswordValid: Bool = false
    @Published var isEmailValid: Bool = false
    @Published var isUsernameValid: Bool = false
    
    var isFirstNameAndSecondNameValid: Bool {
        get {
            return !firstName.isEmpty && !secondName.isEmpty
        }
    }
    
    init() {
        registerNetworkManager = RegistrationNetworkManager()
        loginNetworkManager = LoginNetworkManager()
    }
}

// MARK: - Public func

extension RegistrationViewModel {
    
    func onChangePasswordTextField(_ newValue: String) {
        password = newValue.replacingOccurrences(of: " ", with: "")
        withAnimation {
            if !confirmPassword.isEmpty {validateConfirmPassword()}
            if password.isEmpty {
                passwordPrompt.removeAll()
            } else {
                validatePassword()
            }
        }
    }
    
    func onChangeConfirmPasswordTextField(_ newValue: String) {
        confirmPassword = newValue.replacingOccurrences(of: " ", with: "")
        withAnimation {
            if !password.isEmpty {validatePassword()}
            if confirmPassword.isEmpty {
                confirmPasswordPrompt.removeAll()
            } else {
                validateConfirmPassword()
            }
        }
    }
    
    func setUsername() {
        let usernameRegEx = "^[a-z0-9_.-]+$"
        let usernameTest = NSPredicate(format:"SELF MATCHES[c] %@", usernameRegEx)
        
        guard usernameTest.evaluate(with: username) else {
            isUsernameValid = false
            withAnimation {
                usernamePrompt = "Invalid username format"
            }
            return
        }
        
        checkUsername()
    }
    
    func setPassword() {
        register()
    }
}

// MARK: - RegistrationViewModelNetworkProtocol

extension RegistrationViewModel: RegistrationViewModelNetworkProtocol {
    
    func register() {
        isLoading = true
        let requestModel = RegisterRequestModel(firstName: firstName, secondName: secondName, username: username, email: email, password: password)
        var parametrs: Parameters = [:]
        
        do {
            parametrs = try DictionaryEncoder().encode(requestModel)
        } catch {
            isLoading = false
            print(error.localizedDescription)
        }
        
        registerNetworkManager.register(parameters: parametrs) { [weak self] registrationResponseModel, error in
            defer {
                self?.isLoading = false
            }
            
            if let error = error {
                print(error)
            }
            
            //            guard let registrationResponseModel = registrationResponseModel else {
            //                return
            //            }
            
            print(registrationResponseModel)
            self?.isRegistered = true
        }
    }
    
    func checkUsername() {
        isLoading = true
        let string = username
        
        registerNetworkManager.checkUsername(string: string) { [weak self] isValid, error in
            defer {
                self?.isLoading = false
            }
            
            guard error == nil else {
                self?.isUsernameValid = false
                withAnimation {
                    self?.usernamePrompt = error ?? ""
                }
                return
            }
            
            withAnimation {
                self?.usernamePrompt.removeAll()
            }
            
            if let isValid = isValid {
                self?.isUsernameValid = isValid
            }
        }
    }
    
    func login() {
        
        confirmEmailPrompt = ""
        
        
        isLoading = true
        var parameters: Parameters = [:]
        
        do {
            parameters = try DictionaryEncoder().encode(LoginRequestModel(username: username, password: password))
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
        
        loginNetworkManager.login(parameters: parameters) { [weak self] successResponse, failResponse, error in
            defer {
                withAnimation {
                    self?.isLoading = false
                }
            }
            
            if let error = error {
                self?.confirmEmailPrompt = "Email not confirmed"
                print(error)
                print(failResponse ?? "Fail response")
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

// MARK: - Private func

private extension RegistrationViewModel {
    
    func validateEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
        isEmailValid = emailTest.evaluate(with: email)
        //        guard  else {
        //            emailPrompt = "Invalid email adress"
        //            isEmailValid = false
        //            return
        //        }
    }
    
    func validatePassword() {
        
        let upperLoverCaseRegEx = "^(?=.*[a-z])(?=.*[A-Z]).{1,}$"
        let specialCaseRegEx = "^(?=.*[-_!@#$&*]).{1,}$"
        let digitCaseRegEx = "^(?=.*[0-9]).{1,}$"
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[-_!@#$&*])(?=.*[0-9]).{8,}$"
        
        let upperLoverCaseTest = NSPredicate(format:"SELF MATCHES %@", upperLoverCaseRegEx)
        let specialCaseTest = NSPredicate(format:"SELF MATCHES %@", specialCaseRegEx)
        let digitCaseTest = NSPredicate(format:"SELF MATCHES %@", digitCaseRegEx)
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        passwordPrompt = [
            PasswordPrompt(isValid: password.count>=8, title: "Use at least 8 characters"),
            PasswordPrompt(isValid: upperLoverCaseTest.evaluate(with: password), title: "Use lover and upper case characters"),
            PasswordPrompt(isValid: specialCaseTest.evaluate(with: password), title: "Use special characters -, _, !, @, #, $, &, *"),
            PasswordPrompt(isValid: digitCaseTest.evaluate(with: password), title: "Use 1 or more numbers")
        ]
        
        isPasswordValid = passwordTest.evaluate(with: password)
    }
    
    func validateConfirmPassword() {
        confirmPasswordPrompt = [
            PasswordPrompt(isValid: confirmPassword == password, title: "Password mismatch")
        ]
        
        isConfirmPasswordValid = confirmPassword == password
    }
}
