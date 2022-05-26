//
//  SuccessRegistrationView.swift
//  JobStar
//
//  Created by siyrbayev on 18.05.2022.
//

import SwiftUI

// MARK: - Preview

struct SuccessRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessRegistrationView(viewModel: RegistrationViewModel())
    }
}

struct SuccessRegistrationView: View {
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                Text("You have successfully registered!")
                    .foregroundColor(.tx_pr)
                    .font(.system(size: 22, weight: .bold))
                
                Text("Please press continue")
                    .foregroundColor(.tx_sc)
                    .font(.system(size: 18, weight: .bold))
                    .padding()
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: onContinue) {
                if viewModel.isLoading {
                    ProgressView()
                         .tint(.white)
                } else {
                    Text("Continue")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .frame(width: 164, height: 56, alignment: .center)
            .background(
                LinearGradient(
                    colors: viewModel.isLoading ? [.lb_sc.opacity(0.5), .lb_pr.opacity(0.3), .lb_sc.opacity(0.5)] : [.lb_pr, .lb_sc, .lb_pr, .lb_pr] ,
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .padding(-12)
                .blur(radius: 12)
            )
            .cornerRadius(12)
            .padding(.bottom, 48)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .disabled(viewModel.isLoading)
    }
}

// MARK: - Private func

private extension SuccessRegistrationView {
    
    func onContinue() {
        viewModel.login()
    }
}
