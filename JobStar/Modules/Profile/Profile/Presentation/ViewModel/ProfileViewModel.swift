//
//  ProfileViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import Foundation

fileprivate protocol ProfileViewModelProtocol {
    func getProfileInfo()
    func deleteResume(id: String, _ onSuccess: @escaping () -> Void)
}

class ProfileViewModel: ObservableObject {
    
    private let profileNetworkManager = ApplicantNetworkManager.shared
    private let resumeNetworkManager = ResumeNetworkManager.shared
    
    @Published var applicant: Applicant = AppData.applicant
    @Published var resumes: [Resume] = []
    
    @Published var isLoading: Bool = false
    
    init() {
    }
    
    func onAppear() {
        getProfileInfo()
        applicant = AppData.applicant
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func deleteResume(id: String, _ onSuccess: @escaping () -> Void) {
        
        resumeNetworkManager.deleteResume(with: id) { [weak self] error in
            defer {
                self?.isLoading = false
            }
            
            if let error = error {
                print(error)
                return
            }
            
            onSuccess()
        }
    }
    
    func getProfileInfo() {
        profileNetworkManager.getProfileInfo { [weak self] applicant, error in
            
            if let error = error {
                print(error)
            }
            
            guard let applicant = applicant else {
                return
            }
            
            AppData.applicant = applicant
            self?.applicant = AppData.applicant
        }
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
    
    func deleteResume(with id: String, _ onSuccess: @escaping () -> Void) {
        isLoading = true
        
        deleteResume(id: id, onSuccess)
    }
}


// MARK: - Private func

private extension ProfileViewModel {
    
}

