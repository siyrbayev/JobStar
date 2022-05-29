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
        CreateResumeView(resetData: {})
        //            .previewDevice("iPhone 8")
//                    .preferredColorScheme(.dark)
    }
}

struct CreateResumeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let resetData: (() -> Void)
    
    // MARK: - ObservedObject
    
    @StateObject var viewModel: CreateResumeViewModel = CreateResumeViewModel()
    
    // MARK: - State
    
    @State private var isSkillsListPresented: Bool = false
    @State private var isDeleteWorkTimePeriodAlertActive: Bool = false
    @State private var index: Int?
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $isSkillsListPresented) {
                    AllSkillsListView(createResumeViewModel: viewModel)
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $viewModel.isAddWorkExperiencePresented) {
                    AddWorkTimePeriodView(viewModel: viewModel)
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
                                    .background(Color.fl_pr)
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
                                    .background(Color.fl_pr)
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
                                    .background(Color.fl_pr)
                                    .cornerRadius(6)
                            }
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Description")
                                        .foregroundColor(.tx_sc)
                                        .font(.system(size: 16, weight: .regular))
                                    Spacer()
                                }
                                
                                TextEditor(text: $viewModel.description)
                                    .background(Color.fl_pr)
                                    .frame(height: 172, alignment: .top)
                                    .cornerRadius(6)
                                    .toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            HStack {
                                                Spacer()
                                                
                                                Button(action: { hideKeyboard() }, label: { Text("Done")
                                                        .font(.system(size: 17, weight: .semibold))
                                                })
                                                .padding(.trailing, -8)
                                            }
                                        }
                                    }
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
                            .padding(.bottom)
                        
                        HStack {
                            Text("Work time period")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 18, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: presentWorkExperience) {
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
                        
                        VStack(spacing: 6) {
                            ForEach(viewModel.workTimePeriods.indices, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(viewModel.workTimePeriods[index].positionName ?? "")
                                            .font(.system(size: 18, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Button(action: { deleteWorkTimePeriod(at: index) }) {
                                            Image(systemName: "xmark.circle")
                                                .foregroundColor(.error)
                                                .font(.system(size: 16))
                                        }
                                    }
                                    
                                    HStack {
                                        Text(viewModel.workTimePeriods[index].beginDateTime ?? "")
                                            .font(.system(size: 16))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 14, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text(viewModel.workTimePeriods[index].endDateTime ?? "")
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.tx_sc)
                                }
                                .padding(8)
                                .padding(.vertical, 8)
                                .background(Color.bg_off)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: createResume) {
                            Text("Create")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 48)
                                .padding(.vertical, 12)
                                .background(viewModel.isCreateResumeValid() ? Color.lb_sc : Color.tx_sc.opacity(0.5))
                        }
                        .disabled(!viewModel.isCreateResumeValid())
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismissView) {
                        Image(systemName: "xmark")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
            .alert(isPresented: $isDeleteWorkTimePeriodAlertActive) {
                Alert(
                    title: Text("Delete work time period?"),
                    message: Text("This work time period will be permamently deleted."),
                    primaryButton: .destructive(Text("Delete"), action: {
                        guard let index = self.index else {
                            return
                        }
                        viewModel.workTimePeriods.remove(at: index)
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: {
                        self.index = nil
//                        isDeleteWorkTimePeriodAlertActive.toggle()
                    }))
            }
        }
    }
}


// MARK: - Private func

private extension CreateResumeView {
    
    func dismissView() {
        dismiss()
        resetData()
    }
    
    func presentSkills() {
        isSkillsListPresented.toggle()
    }
    
    func presentWorkExperience() {
        viewModel.isAddWorkExperiencePresented.toggle()
    }
    
    func createResume() {
        viewModel.onCreateResume {
            dismissView()
        }
    }
    
    func deleteWorkTimePeriod(at index: Int) {
        self.index = index
        isDeleteWorkTimePeriodAlertActive.toggle()
    }
}
