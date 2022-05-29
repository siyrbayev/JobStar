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
        //                    .preferredColorScheme(.dark)
    }
}

struct SuccessRegistrationView: View {
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                Group {
                    
                    Spacer()
                    
                    Image(systemName: "envelope.badge")
                        .padding(20)
                        .foregroundColor(.accent_pr)
                        .imageScale(.large)
                        .font(.system(size: 34))
                        .background(
                            LinearGradient(
                                colors: [.bg_off, .bg_clear, .bg_off, .bg_clear],
                                startPoint: .center,
                                endPoint: .topLeading)
                            .blur(radius: 4)
                            //                        Color.bg_clear
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.tx_sc.opacity(0.4), radius: 14, x: 4, y: 6)
                    
                        .shadow(color: Color.accent_pr.opacity(0.15), radius: 14, x: -6, y: -6)
                        .padding(.bottom)
                    
                    
                    Text("Confirm your email address")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.bottom)
                    
                    Text("We sent a confirmation email to:")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.tx_off)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top)
                    
                    Text(viewModel.email)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accent_pr)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top, 4)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text(viewModel.confirmEmailPrompt)
                    .transition(.opacity)
                    .foregroundColor(.error)
                    .shadow(color: .error, radius: 32, x: 0, y: 0)
                    .font(.system(size: 16, weight: .medium))
                    .frame(height: 48)
                
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
                .shadow(color: Color.bg_sc.opacity(1), radius: 14, x: 4, y: 6)
                .shadow(color: Color.accent_pr.opacity(0.2), radius: 14, x: -6, y: -6)
                .padding(.bottom, 48)
                
                
            }
            Spacer()
        }
        .background(Color.bg_off)
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
