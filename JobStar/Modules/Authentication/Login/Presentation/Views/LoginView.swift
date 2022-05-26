//
//  LoginView.swift
//  JobStar
//
//  Created by siyrbayev on 10.04.2022.
//

import SwiftUI

// MARK: - Previews

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
//            .previewDevice("iPhone 8")
//            .preferredColorScheme(.dark)
    }
}

protocol LoginViewProtocol {
    func login()
}

struct LoginView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    // MARK: - State
    
    @State private var isAlertShown: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Group {
                    Spacer()
                    Image("")
                        .frame(width: 156, height: 156, alignment: .center)
                        .background(
                            ZStack {
                                Color.gray
                                Text("LOGO")
                            }
                        )
                    
                    Spacer()
                }
                
                Group {
                    warningMessagesPromt
                    
                    VStack(spacing: 8) {
                        usernameTextField
                        
                        passwordTextField
                    }
                }
                
                Spacer()
                Spacer()
                
                Group {
                    loginButton
                }
                
                HStack {
                    VStack {
                        Divider()
                    }
                    
                    Text("or")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.tx_sc)
                        .padding(.horizontal, 8)
                    
                    VStack {
                        Divider()
                    }
                }
                
                Group {
                    registrationButton
                    
                    Spacer()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.bg_clear)
            .onTapGesture {
                hideKeyboard()
            }
            .onAppear {
                viewModel.onAppear()
            }
            .alert(isPresented: $viewModel.isAlertPresents, content: viewModel.alert)
            .disabled(viewModel.isLoading)
        }
    }
    
    // MARK: - WarningMessagesPromt
    
    var warningMessagesPromt: some View {
        HStack {
            Image(systemName: "exclamationmark.octagon.fill")
                .foregroundColor(.error)
                .imageScale(.large)
                .frame(width: 56, height: 56, alignment: .center)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Whoops, here is an error message.")
                    .foregroundColor(.error)
                    .font(.system(size: 14, weight: .medium))
                
                Text(viewModel.errorMessagePrompt)
                    .foregroundColor(.tx_pr)
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(.vertical, 8)
            
            Spacer()
        }
        .background(
            Color.bg_off
                .cornerRadius(12)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0.5)
                .foregroundColor(.error)
                .blur(radius: 2)
        )
        .padding(.horizontal)
        .padding(.vertical, 12)
        .isHidden(viewModel.errorMessagePrompt.isEmpty)
    }
    
    // MARK: - UsernameTextField
    
    var usernameTextField: some View {
        HStack(spacing: 0) {
            Image(systemName: "person.fill")
                .frame(width: 40, height: 40)
            
            
            TextField("Username", text: $viewModel.username)
                .frame(height: 56)
                .cornerRadius(12)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    login()
                }
            
            if !viewModel.usernamePrompt.isEmpty {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.error)
                    .frame(width: 40, height: 40)
            } else {
                Spacer(minLength: 40)
                    .frame(width: 40, height: 40)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0.5)
                .foregroundColor(viewModel.usernamePrompt.isEmpty ? .none : .error)
                .blur(radius: 2)
        )
        .background(
            ZStack {
                Color.fl_pr
                    .cornerRadius(12)
                if !viewModel.usernamePrompt.isEmpty {
                    HStack {
                        Spacer()
                        
                        Text(viewModel.usernamePrompt)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.error)
                            .padding(.trailing, 40)
                    }
                }
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - PasswordTextField
    
    var passwordTextField: some View {
        HStack(spacing: 0) {
            Image(systemName: "lock.fill")
                .frame(width: 40, height: 40)
            
            SecureField("Password", text: $viewModel.password)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .frame(height: 56)
                .cornerRadius(12)
                .onSubmit {
                    login()
                }
            
            if !viewModel.passwordPrompt.isEmpty {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.error)
                    .frame(width: 40, height: 40)
            } else {
                Spacer(minLength: 40)
                    .frame(width: 40, height: 40)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0.5)
                .foregroundColor(viewModel.passwordPrompt.isEmpty ? .none : .error)
                .blur(radius: 2)
        )
        .background(
            ZStack {
                Color.fl_pr
                    .cornerRadius(12)
                if !viewModel.passwordPrompt.isEmpty {
                    HStack {
                        Spacer()
                        
                        Text(viewModel.passwordPrompt)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.error)
                            .padding(.trailing, 40)
                    }
                }
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - LoginButton
    
    var loginButton: some View {
        Button(action: login) {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Login")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 172, height: 60, alignment: .center)
        }
        .background(
            LinearGradient(
                colors: !isLoginActive() ? [.lb_pr] : viewModel.isLoading ? [.lb_pr, .lb_pr, .lb_sc, .lb_pr] : [.lb_pr] ,
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .blur(radius: !isLoginActive() ? 0.5 : 1)
            .opacity(isLoginActive() ? 1 : 0.5)
        )
        .cornerRadius(12)
        .padding()
    }
    
    // MARK: - RegistrationButton
    
    var registrationButton: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            Text("Create new account")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.success)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 12, x: 4, y: 4)
        }
    }
    
}

// MARK: - LoginViewProtocol

extension LoginView: LoginViewProtocol {
    
    func login() {
        viewModel.login()
    }
}

// MARK: - Private func

private extension LoginView {
    
    func isLoginActive() -> Bool {
        withAnimation {
            !viewModel.password.isEmpty && !viewModel.username.isEmpty
        }
    }
}
