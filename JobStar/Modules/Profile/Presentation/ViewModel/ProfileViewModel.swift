//
//  ProfileViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: Applicant = AppData.applicant
    @Published var resumes: [Resume] = []
    
    init() { }
    
    func onAppear() {
        user = AppData.applicant
    }
}

// MARK: - Public func

extension ProfileViewModel {
    
    func logOut() {
        AppData.applicant = Applicant()
        AppData.username = ""
        AppData.jsonWebToken = ""
        AppData.isAuthenticated = false
    }
    
    func addResume() {
        
    }
}

// MARK: - Private func

private extension ProfileViewModel {
    
}

