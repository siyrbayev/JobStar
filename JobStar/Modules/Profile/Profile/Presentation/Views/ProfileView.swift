//
//  ProfileView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

// MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
//            .preferredColorScheme(.dark)
    }
}

struct ProfileView: View {
    
    // MARK: - StateObject
    
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
//    @StateObject var createResumeViewModel: CreateResumeViewModel = CreateResumeViewModel()
    
    // MARK: - State
    @State private var isCreateResumePresented: Bool = false
    @State private var isMoreAboutShown: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                    ScrollView {
                        header
                        
                        skils
                            .isHidden((profileViewModel.applicant.skills ?? []).isEmpty, remove: true)
                        
                        resumes
                    }
            }
            .onAppear{
                profileViewModel.onAppear()
            }
            .fullScreenCover(isPresented: $isCreateResumePresented, content: {
                CreateResumeView(resetData: {profileViewModel.getProfileInfo()})
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Profile")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 32, weight: .bold))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: editUser) {
                            Label {
                                Text("Edit user")
                                    .font(.system(size: 12, weight: .medium))
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        Button(role: .destructive, action: logOut) {
                            Label {
                                Text("Log out")
                                    .font(.system(size: 12, weight: .medium))
                            } icon: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                        }
                    } label: {
                        Image(systemName: "gearshape")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
        }
    }
    
    // MARK: - Header
    
    var header: some View {
        VStack {
            HStack(alignment: .top) {
                if (profileViewModel.applicant.profilePhoto ?? "").isEmpty {
                    Image("avatar")
                        .resizable()
                        .padding(8)
                        .frame(width: 72, height: 72, alignment: .center)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(.infinity)
                        .padding()
                } else {
                    KFImageView(
                        url: profileViewModel.applicant.profilePhoto ?? "",
                        placeholder:
                            Image(systemName: "person")
                    )
                    .background(Color.bg_off)
                    .frame(width: 72, height: 72, alignment: .center)
                    .cornerRadius(.infinity)
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("\(profileViewModel.applicant.firstName ?? "") \(profileViewModel.applicant.secondName ?? "")")
                        .font(.system(size: 20, weight: .medium))
                        .lineLimit(1)
                    
                    Text(profileViewModel.applicant.email ?? "")
                        .font(.system(size: 14, weight: .medium))
                        .lineLimit(1)
                        .padding(.bottom, 8)
                    
                    Text(profileViewModel.applicant.about ?? "")
                        .lineLimit(isMoreAboutShown ? 10 : 0)
                        .font(.system(size: 15, weight: .regular))
                    
                    Button(action: moreAbout) {
                        Text(isMoreAboutShown ? "less" : "more")
                            .foregroundColor(.lb_pr)
                    }
                    .isHidden((profileViewModel.applicant.about ?? "").isEmpty, remove: true)
                }
                .padding([.trailing, .top], 16)
                .foregroundColor(.tx_pr)
                
                Spacer()
            }
            .padding(.bottom)
        }
        .background(
            LinearGradient(colors: [.clear, .gray.opacity(0.1), .gray.opacity(0.1), .gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .cornerRadius(24)
        )
    }
    
    // MARK: - Skils
    
    var skils: some View {
        VStack {
            HStack {
                Text("Skills")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.horizontal)
                
                Spacer()
            }
            
            SkillsView(skills: profileViewModel.applicant.skills ?? [])
                .padding()
        }
    }
    
    // MARK: - Resumes
    
    var resumes: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Resumes")
                .font(.system(size: 22, weight: .bold))
                .padding(.horizontal)
                
                Spacer()
            }
            
            VStack {
                Button(action: presentCreateResumeView) {
                    HStack(spacing: 0) {
                        Spacer()
                        
                        Text("Create Resume")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.trailing, 4)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                    }
                    .foregroundColor(.accent_pr)
                    .padding()
                }
                .background(Color.bg_sc)
                .cornerRadius(12)
                .padding(.horizontal)
                
                ForEach(profileViewModel.applicant.resumes ?? []) { resume in
                    ResumeRowItemView(resume: resume)
                        .padding(.horizontal)
                }
            }
        }
    }
}

extension ProfileView {
    
    func moreAbout() {
        withAnimation {
            isMoreAboutShown.toggle()
        }
    }
}

// MARK: - Preview

private extension ProfileView {
    
    func logOut() {
        profileViewModel.logOut()
    }
    
    func editUser() {
        
    }
    
    func presentCreateResumeView() {
        isCreateResumePresented.toggle()
    }
}
