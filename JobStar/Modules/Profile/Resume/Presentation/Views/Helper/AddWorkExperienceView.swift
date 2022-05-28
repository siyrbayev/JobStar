//
//  AddWorkExperienceView.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import SwiftUI

// MARK: - Previews

struct AddWorkExperienceView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddWorkExperienceView(viewModel: CreateResumeViewModel())
    }
}

struct AddWorkExperienceView: View {
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: CreateResumeViewModel
    
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
                
                CustomUITextField(text: $viewModel.positionName)
                    .frame(height: 38)
                    .padding(.leading, 16)
                    .background(Color.bg_sc)
                    .cornerRadius(6)
            }
            
            DatePicker("Begin date", selection: $viewModel.beginDateTime, in: ...Date(), displayedComponents: [.date])
            DatePicker("End date", selection: $viewModel.endDateTime, in: viewModel.beginDateTime... ,  displayedComponents: [.date])
        }
        .padding(.horizontal)
    }
}
