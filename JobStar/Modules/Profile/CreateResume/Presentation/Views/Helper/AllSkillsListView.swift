//
//  AllSkillsListView.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import SwiftUI

// MARK: - Previews

struct AllSkillsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        AllSkillsListView(createResumeViewModel: CreateResumeViewModel())
    }
}

struct AllSkillsListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - StateObject
    
    @StateObject private var allSkillListViewModel: AllSkillListViewModel = AllSkillListViewModel()
    
    // MARK: - ObservedObject
    
    @ObservedObject var createResumeViewModel: CreateResumeViewModel
    
    // MARK: - State
    
    @State private var isAlertActive: Bool = false
    @State private var alertSkillName: String = ""
    @State private var searchText: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomUISearchBar(text: $searchText, placeholder: "Search", isFirstResponder: true, onCancelButtonClicked: {
                    searchText = ""
                })
                .padding(.horizontal, 8)
                
                ScrollView {
                    AlertControlView(textString: $alertSkillName, showAlert: $isAlertActive, title: "Create custom Skill", message: "") {
                        let skill = Skill(skill: alertSkillName)
                        createResumeViewModel.skills.append(skill)
                        createResumeViewModel.customSkills.append(skill)
                        alertSkillName.removeAll()
                    }
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 0) {
                            HStack {
                                Text("Custom skills")
                                    .foregroundColor(.tx_off)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal)
                                    .isHidden(createResumeViewModel.customSkills.isEmpty, remove: true)
                                
                                Spacer()
                            }
                            
                            
                            ForEach(createResumeViewModel.customSkills
                                .filter({ searchText.isEmpty ? true : $0.skill?.lowercased().contains(searchText.lowercased()) ?? false })
                            ) { skill in
                                Button {
                                    if createResumeViewModel.skills.contains(skill) {
                                        removeSkill(skill)
                                    } else {
                                        addSkill(skill)
                                    }
                                } label: {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text(skill.skill ?? "")
                                                .foregroundColor(.tx_pr)
                                                .font(.system(size: 20, weight: .regular))
                                                .padding(.top, 12)
                                                .padding(.bottom, 4)
                                            Spacer()
                                            
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 16))
                                                .foregroundColor(.tx_sc)
                                                .isHidden(!createResumeViewModel.skills.contains(skill))
                                        }
                                        Divider()
                                            .foregroundColor(.tx_sc)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("General skills")
                                    .foregroundColor(.tx_off)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal)
                                    .isHidden(allSkillListViewModel.allSkills.isEmpty, remove: true)
                                
                                Spacer()
                            }
                            
                            ForEach(allSkillListViewModel.allSkills
                                .filter({ searchText.isEmpty ? true : $0.skill?.lowercased().contains(searchText.lowercased()) ?? false })
                            ) { skill in
                                Button {
                                    if createResumeViewModel.skills.contains(skill) {
                                        removeSkill(skill)
                                    } else {
                                        addSkill(skill)
                                    }
                                } label: {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text(skill.skill ?? "")
                                                .foregroundColor(.tx_pr)
                                                .font(.system(size: 20, weight: .regular))
                                                .padding(.top, 12)
                                                .padding(.bottom, 4)
                                            Spacer()
                                            
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 16))
                                                .foregroundColor(.tx_sc)
                                                .isHidden(!createResumeViewModel.skills.contains(skill))
                                        }
                                        Divider()
                                            .foregroundColor(.tx_sc)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 72)
                }
            }
            
            VStack {
                Spacer()
                
                Button {
                    isAlertActive.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("+ Add custom Skill")
                            .foregroundColor(.accent_pr)
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                }
                .padding()
            }
        }
        .onAppear {
            allSkillListViewModel.getAllSkills()
        }
        .navigationTitle("Skills")
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

private extension AllSkillsListView {
    
    func dismissView() {
        dismiss()
    }
    
    func addSkill(_ skill: Skill) {
        createResumeViewModel.skills.append(skill)
    }
    
    func removeSkill(_ skill: Skill) {
        createResumeViewModel.skills.removeAll(where: { $0 == skill })
    }
}

