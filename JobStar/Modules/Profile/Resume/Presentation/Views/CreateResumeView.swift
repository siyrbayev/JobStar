//
//  CreateResumeView.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import SwiftUI

// MARK: - Previews

struct CreateResumeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateResumeView(viewModel: CreateResumeViewModel())
//            .previewDevice("iPhone 8")
//            .preferredColorScheme(.dark)
    }
}

struct CreateResumeView: View {
    
    // MARK: - ObservedObject
    
    @ObservedObject var viewModel: CreateResumeViewModel
    
    // MARK: - State
    
    @State private var isSkillsListPresented: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $isSkillsListPresented) {
                    AllSkillsListView(createResumeViewModel: viewModel)
                } label: {
                    EmptyView()
                }
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(spacing: 6) {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Title*")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                CustomUITextField(text: $viewModel.title)
                                    .frame(height: 38)
                                    .padding(.leading, 16)
                                    .background(Color.bg_sc)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("First Name*")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                CustomUITextField(text: $viewModel.firstName)
                                    .frame(height: 38)
                                    .padding(.leading, 16)
                                    .background(Color.bg_sc)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Second Name*")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                CustomUITextField(text: $viewModel.secondName)
                                    .frame(height: 38)
                                    .padding(.leading, 16)
                                    .background(Color.bg_sc)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Mobile phone*")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                CustomUITextField(text: $viewModel.mobilePhone)
                                    .frame(height: 38)
                                    .padding(.leading, 16)
                                    .background(Color.bg_sc)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Email*")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                CustomUITextField(text: $viewModel.email)
                                    .frame(height: 38)
                                    .padding(.leading, 16)
                                    .background(Color.bg_sc)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Description")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                TextView(text: $viewModel.description, textStyle: .constant(.body), backgroundColor: UIColor(.bg_sc))
                                    .frame(height: 172, alignment: .top)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.top, 32)
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Skills*")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 18, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: presentSkills) {
                                Text("+ add")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.accent_pr)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding([.top, .horizontal])
                        
                        SkillsView(skills: viewModel.skills)
                            .isHidden(viewModel.skills.isEmpty, remove: true)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Work Experience")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 18, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: presentSkills) {
                                Text("+ add")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.accent_pr)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding([.top, .horizontal])
                        
                        Button(action: createResume) {
                            Text("Create")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 48)
                                .padding(.vertical, 12)
                                .background(Color.lb_sc)
                        }
                        .cornerRadius(12)
                        .padding(.top, 32)
                        .padding(.bottom)
                    }
                    .background(
                        Color.bg_clear
                            
                    )
                }
            }
            .navigationTitle("Create new resume")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismissView) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.tx_pr)
                    }
                }
                
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        
                        Button {
                            hideKeyboard()
                        } label: {
                            Text("Hide")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Private func

private extension CreateResumeView {
    
    func dismissView() {
        viewModel.isPresented.toggle()
    }
    
    func presentSkills() {
        isSkillsListPresented.toggle()
    }
    
    func createResume() {
        
    }
}
