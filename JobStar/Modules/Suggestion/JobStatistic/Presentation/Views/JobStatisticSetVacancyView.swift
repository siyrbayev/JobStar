//
//  JobStatisticSetVacancyView.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import SwiftUI

struct JobStatisticSetVacancyView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: JobStatisticViewModel
    
    // MARK: - Binding
    
    @Binding var isPresented: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            CustomUISearchBar(text: $viewModel.wordToFind)
            
            Spacer()
            
            Button {
                viewModel.search()
                isPresented = false
            } label: {
                Text("Find")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 48)
                    .padding(.vertical)
                    .background(
                        LinearGradient(colors: [.lb_pr, .lb_sc, .lb_sc, .lb_pr], startPoint: .topLeading, endPoint: .bottom)
                            .padding(0)
                            .blur(radius: 12)
                            .background(
                                Color.bg_off
                            )
                    )
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismissView) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.accent_pr)
                            .font(.system(size: 22, weight: .medium))
                            .imageScale(.large)
                    }
                }
            }
    }
    
    private func dismissView() {
        dismiss()
    }
}

// MARK: - Preview

struct JobStatistiSetVacancyView_Previews: PreviewProvider {
    static var previews: some View {
        JobStatisticSetVacancyView(viewModel: JobStatisticViewModel(), isPresented: .constant(true))
    }
}
