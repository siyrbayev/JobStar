//
//  AddWorkTimePeriodView.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import SwiftUI

// MARK: - Previews

struct AddWorkTimePeriodView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddWorkTimePeriodView(viewModel: CreateResumeViewModel())
    }
}

struct AddWorkTimePeriodView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: CreateResumeViewModel
    
    @State private var isPositionNameValid: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Position name*")
                        .foregroundColor(.tx_sc)
                        .font(.system(size: 16, weight: .regular))
                    Spacer()
                }
                
                CustomUITextField(text: $viewModel.positionName, isFirstResponder: true)
                    .frame(height: 38)
                    .padding(.leading, 16)
                    .background(Color.fl_pr)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 0.2)
                            .foregroundColor(viewModel.isPositionNameInvalid ? .error : .clear)
                            .blur(radius: 2)
                    )
            }
            
            DatePicker("Begin date", selection: $viewModel.beginDateTime, in: ...Date(), displayedComponents: [.date])
            
            DatePicker("End date", selection: $viewModel.endDateTime, in: viewModel.beginDateTime... ,  displayedComponents: [.date])
            
            Button(action: createWorkExperience) {
                HStack {
                    Spacer()
                    
                    Text("Create")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.accent_pr)
                        .padding(.vertical, 12)
                    
                    Spacer()
                }
                .background(Color.gray.opacity(0.15))
                .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onDisappear {
            viewModel.positionName.removeAll()
            viewModel.beginDateTime = Date()
            viewModel.endDateTime = Date()
        }
        .navigationTitle("Work time period")
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
}

private extension AddWorkTimePeriodView {
    
    func dismissView() {
        dismiss()
    }
    
    func createWorkExperience() {
        if viewModel.positionName.isEmpty {
            viewModel.isPositionNameInvalid = true
        }
        viewModel.addWorkExperience()
    }
}
