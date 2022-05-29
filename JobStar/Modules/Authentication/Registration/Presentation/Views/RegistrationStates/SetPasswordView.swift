//
//  SetPasswordView.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import SwiftUI


// MARK: - Preview

struct SetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SetPasswordView(viewModel: RegistrationViewModel())
    }
}

struct SetPasswordView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $viewModel.isRegistered) {
                SuccessRegistrationView(viewModel: viewModel)
            } label: {
                EmptyView()
            }
            Group {
                Text("Please write password")
                
                passwordTextField
                
                confirmPasswordTextField
            }
            
            Spacer()
            
            nextButton
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismissView) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 16, weight: .medium))
                }
            }
        }
    }
    
    // MARK: - PasswordTextField
    
    var passwordTextField: some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "person.fill")
                    .frame(width: 40, height: 40)
                
                
                TextField("Password", text: $viewModel.password)
                    .frame(height: 56)
                    .cornerRadius(12)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        register()
                    }
                    .onChange(of: viewModel.password) { newValue in
                        onChangePasswordTextField(newValue)
                    }
                
                if viewModel.isPasswordValid {
                    Image(systemName: "checkmark")
                        .foregroundColor(.success)
                        .frame(width: 40, height: 40)
                } else {
                    if !viewModel.passwordPrompt.isEmpty {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.error)
                            .frame(width: 40, height: 40)
                    } else {
                        Spacer(minLength: 40)
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 0.2)
                    .foregroundColor(viewModel.isPasswordValid ? .success : viewModel.passwordPrompt.isEmpty ? .clear : .error)
                    .blur(radius: 2)
            )
            .background(
                ZStack {
                    Color.fl_pr
                        .cornerRadius(12)
                }
            )
            
            VStack {
                ForEach(viewModel.passwordPrompt) { prompt in
                    
                    
                    HStack {
                        if prompt.isValid {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "xmark.circle")
                        }
                        
                        Text(prompt.title)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                    }
                    .foregroundColor(prompt.isValid ? .success : .error)
                }
            }
            .padding()
            .isHidden(viewModel.passwordPrompt.isEmpty, remove: true)
        }
        .background(
            ZStack {
                Color.fl_pr.opacity(0.9)
                    .cornerRadius(12)
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - ConfirmPasswordTextField
    
    var confirmPasswordTextField: some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "person.fill")
                    .frame(width: 40, height: 40)
                
                TextField("Confirm password", text: $viewModel.confirmPassword)
                    .frame(height: 56)
                    .cornerRadius(12)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        register()
                    }
                    .onChange(of: viewModel.confirmPassword) { newValue in
                        onChangeConfirmPasswordTextField(newValue)
                    }
                
                if viewModel.isConfirmPasswordValid {
                    Image(systemName: "checkmark")
                        .foregroundColor(.success)
                        .frame(width: 40, height: 40)
                } else {
                    if !viewModel.passwordPrompt.isEmpty {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.error)
                            .frame(width: 40, height: 40)
                    } else {
                        Spacer(minLength: 40)
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 0.2)
                    .foregroundColor(viewModel.isConfirmPasswordValid ? .success : viewModel.confirmPasswordPrompt.isEmpty ? .clear : .error)
                    .blur(radius: 2)
            )
            .background(
                ZStack {
                    Color.fl_pr
                        .cornerRadius(12)
                }
            )
            VStack {
                ForEach(viewModel.confirmPasswordPrompt) { prompt in
                    
                    
                    HStack {
                        if prompt.isValid {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "xmark.circle")
                        }
                        
                        Text(prompt.title)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                    }
                    .foregroundColor(prompt.isValid ? .success : .error)
                }
            }
            .padding()
            .isHidden(viewModel.confirmPasswordPrompt.isEmpty, remove: true)
        }
        .background(
            ZStack {
                Color.fl_pr.opacity(0.9)
                    .cornerRadius(12)
            }
        )
        .padding(.horizontal)
        .padding(.bottom)
    }
        
    // MARK: - NextButton
    
    var nextButton: some View {
        Button(action: register) {
            Text("Next")
                .foregroundColor(.white)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .background(
                    Color.lb_sc
                        .opacity(viewModel.isPasswordValid ? 1 : 0.5)
                        .cornerRadius(12)
                )
        }
        .padding()
        .disabled(!viewModel.isPasswordValid)
    }
    
}

// MARK: - Private func

private extension SetPasswordView {
    
    func onChangePasswordTextField(_ newValue: String) {
        viewModel.onChangePasswordTextField(newValue)
    }
    
    func onChangeConfirmPasswordTextField(_ newValue: String) {
        viewModel.onChangeConfirmPasswordTextField(newValue)
    }
    
    func register() {
        viewModel.setPassword()
    }
    
    func dismissView() {
        dismiss()
    }
}

