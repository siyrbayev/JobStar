//
//  SetFirstNameAndSecondNameView.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import SwiftUI

// MARK: - Preview

struct SetFirstNameAndSecondNameView_Previews: PreviewProvider {
    static var previews: some View {
        SetFirstNameAndSecondNameView(viewModel: RegistrationViewModel())
    }
}

struct SetFirstNameAndSecondNameView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Group {
                Text("What is your name?")
                
                firstNameTextField
                
                secondNameTextField
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
    
    // MARK: - FirstNameTextField
    
    var firstNameTextField: some View {
        HStack(spacing: 0) {
            Image(systemName: "person.fill")
                .frame(width: 40, height: 40)
            
            
            TextField("First name", text: $viewModel.firstName)
                .frame(height: 56)
                .cornerRadius(12)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    next()
                }
                .onChange(of: viewModel.firstName) { newValue in
                    viewModel.firstName = newValue.replacingOccurrences(of: " ", with: "")
                }
            
            if !viewModel.firstNamePrompt.isEmpty {
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
                .stroke(lineWidth: 0.2)
                .foregroundColor(viewModel.firstNamePrompt.isEmpty ? .none : .error)
                .blur(radius: 2)
        )
        .background(
            ZStack {
                Color.fl_pr
                    .cornerRadius(12)
                if !viewModel.firstNamePrompt.isEmpty {
                    HStack {
                        Spacer()
                        
                        Text(viewModel.firstNamePrompt)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.error)
                            .padding(.trailing, 40)
                    }
                }
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - SecondNameTextField
    
    var secondNameTextField: some View {
        HStack(spacing: 0) {
            Image(systemName: "person.fill")
                .frame(width: 40, height: 40)
            
            TextField("Second name", text: $viewModel.secondName)
                .frame(height: 56)
                .cornerRadius(12)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    next()
                }
                .onChange(of: viewModel.secondName) { newValue in
                    viewModel.secondName = newValue.replacingOccurrences(of: " ", with: "")
                }
            
            if !viewModel.secondNamePrompt.isEmpty {
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
                .stroke(lineWidth: 0.2)
                .foregroundColor(viewModel.secondNamePrompt.isEmpty ? .none : .error)
                .blur(radius: 2)
        )
        .background(
            ZStack {
                Color.fl_pr
                    .cornerRadius(12)
                if !viewModel.secondNamePrompt.isEmpty {
                    HStack {
                        Spacer()
                        
                        Text(viewModel.secondNamePrompt)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.error)
                            .padding(.trailing, 40)
                    }
                }
            }
        )
        .padding(.horizontal)
    }
    
    // MARK: - NextButton
    
    var nextButton: some View {
        NavigationLink {
            SetUsernameView(viewModel: viewModel)
        } label: {
            Text("Next")
                .foregroundColor(.white)
                .padding(.horizontal, 48)
                .padding(.vertical, 12)
                .background(
                    Color.lb_sc
                        .opacity(viewModel.isFirstNameAndSecondNameValid ? 1 : 0.5)
                        .cornerRadius(12)
                )
            
        }
        .padding()
        .disabled(!viewModel.isFirstNameAndSecondNameValid)
    }
    
}

// MARK: - Private func

private extension SetFirstNameAndSecondNameView {
    
    func next() {
        
    }
    
    func dismissView() {
        dismiss()
    }
}
