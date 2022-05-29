//
//  SetEmailView.swift
//  JobStar
//
//  Created by siyrbayev on 18.05.2022.
//

import Foundation
import SwiftUI

// MARK: - Preview

struct SetEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SetEmailView(viewModel: RegistrationViewModel())
    }
}

struct SetEmailView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            Group {
                Text("Please write your email")
                
                emailTextField
                
                HStack {
                    Text(viewModel.emailPrompt)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.error)
                        .padding(.trailing, 40)
                    
                    Spacer()
                }
                .padding()
                .isHidden(viewModel.emailPrompt.isEmpty, remove: true)
            }
            
            Spacer()
            
            nextButton
        }
        .disabled(viewModel.isLoading)
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
    
    // MARK: - EmailTextField
    
    var emailTextField: some View {
        HStack(spacing: 0) {
            Image(systemName: "envelope")
                .frame(width: 40, height: 40)
            
            TextField("Email", text: $viewModel.email)
                .frame(height: 56)
                .cornerRadius(12)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.email) { newValue in
                    viewModel.email = newValue.replacingOccurrences(of: " ", with: "")
                }
            
            if !viewModel.emailPrompt.isEmpty {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.error)
                    .frame(width: 40, height: 40)
            } else {
                Spacer(minLength: 40)
                    .frame(width: 40, height: 40)
            }
        }
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
        NavigationLink {
            SetFirstNameAndSecondNameView(viewModel: viewModel)
        } label: {
            Text("Next")
                .foregroundColor(.white)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .background(
                    Color.lb_sc
                        .opacity(viewModel.isEmailValid ? 1 : 0.5)
                        .cornerRadius(12)
                )
        }
        .padding()
        .disabled(!viewModel.isEmailValid)
    }
}

// MARK: - Private func

private extension SetEmailView {
    
    func dismissView() {
        dismiss()
    }
}
