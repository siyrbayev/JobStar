//
//  TabViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 17.03.2022.
//

import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    
    var networkManager: ProfileNetworkManagerProtocol!
    
    init() {
        AppData.isFirstLaunch = false
        
        networkManager = ProfileNetworkManager()
        
        getProfileInfo()
    }
    
    func onApper() {
    }
}

private extension TabBarViewModel {
    
    func getProfileInfo() {
        networkManager.getProfileInfo { applicant, error in
            if let error = error {
                print(error)
            }
            
            guard let applicant = applicant else {
                return
            }
            
            AppData.applicant = applicant
        }
    }
}

