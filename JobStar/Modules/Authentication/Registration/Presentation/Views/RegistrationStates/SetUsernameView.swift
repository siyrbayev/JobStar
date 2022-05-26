//
//  SetUsernameView.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import SwiftUI

// MARK: - Preview

struct SetUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        SetUsernameView(viewModel: RegistrationViewModel())
    }
}

struct SetUsernameView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - State
    
    @State private var isNavigationNextActive: Bool = false
    
    let usernameFormats: [String] = [" • chars a-z", " • digits (0-9)", " • symbols . _ - "]
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Group {
                NavigationLink(isActive: $isNavigationNextActive) {
                    SetPasswordView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }
                
                Text("Please write username")
                
                usernameTextField
                
                warningMessagesPromt
                
                VStack {
                    HStack {
                        Text("Username format:")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.tx_sc)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    ForEach(usernameFormats, id: \.self) { format in
                        HStack {
                            Text(format)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.tx_sc)
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
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
                        .font(.system(size: 22, weight: .medium))
                        .imageScale(.large)
                }
            }
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
                
                Text(viewModel.usernamePrompt)
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
        .isHidden(viewModel.usernamePrompt.isEmpty, remove: true)
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
                    next()
                }
                .onChange(of: viewModel.username) { newValue in
                    viewModel.username = newValue.replacingOccurrences(of: " ", with: "")
                    checkUsername()
                }
            
            if viewModel.isLoading {
                ProgressView()
                    .foregroundColor(.tx_sc)
                    .frame(width: 40, height: 40)
            } else {
                if viewModel.isUsernameValid {
                    Image(systemName: "checkmark")
                        .foregroundColor(.success)
                        .frame(width: 40, height: 40)
                } else {
                    if !viewModel.usernamePrompt.isEmpty {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.error)
                            .frame(width: 40, height: 40)
                    } else {
                        Spacer(minLength: 40)
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 0.2)
                .foregroundColor(viewModel.isUsernameValid ? .success : viewModel.usernamePrompt.isEmpty ? .none : .error)
                .blur(radius: 2)
        )
        .background(
            ZStack {
                Color.fl_pr
                    .cornerRadius(12)
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - NextButton
    
    var nextButton: some View {
        Button(action: next) {
            Text("Next")
                .foregroundColor(.white)
                .padding(.horizontal, 48)
                .padding(.vertical, 24)
                .background(
                    Color.lb_sc
                        .opacity(!viewModel.isUsernameValid || viewModel.isLoading ? 0.5 : 1)
                        .cornerRadius(12)
                )
        }
        .padding()
        .disabled(!viewModel.isUsernameValid || viewModel.isLoading)
    }
    
}

// MARK: - Private func

private extension SetUsernameView {
    
    func next() {
        isNavigationNextActive = true
    }
    
    func checkUsername() {
        if !viewModel.username.isEmpty {
            viewModel.setUsername()
        }
    }
    
    func dismissView() {
        dismiss()
    }
}
