//
//  ProfileViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import Foundation

fileprivate protocol ProfileViewModelProtocol {
    func getProfileInfo()
}

class ProfileViewModel: ObservableObject {
    
    private let profileNetworkManager: ProfileNetworkManagerProtocol
    
    @Published var applicant: Applicant = AppData.applicant
    @Published var resumes: [Resume] = []
    
    @Published var isLoading: Bool = false
    
    init() {
        profileNetworkManager = ProfileNetworkManager()
    }
    
    func onAppear() {
        getProfileInfo()
        applicant = AppData.applicant
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
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
}


// MARK: - Private func

private extension ProfileViewModel {
    
}

