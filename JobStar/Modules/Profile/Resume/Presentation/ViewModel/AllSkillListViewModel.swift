//
//  AllSkillListViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import Foundation

class AllSkillListViewModel: ObservableObject {
    
    private let networkManager: SkillNetworkManagerProtocol
    
    @Published var allSkills: [Skill] = []
    @Published var addedSkills: [Skill] = []
    @Published var isLoading: Bool = false
    
    init() {
        networkManager = SkillNetworkManager()
    }
    
    func getAllSkills() {
        isLoading = true
        
        networkManager.getAllSkills { [weak self] skills, error in
            defer {
                self?.isLoading = false
            }
            if let error = error, !error.isEmpty {
                print(error)
                return
            }
            
            guard let skills = skills else {
                return
            }
            
            self?.allSkills = skills
            
        }
    }
}

extension AllSkillListViewModel {
    
    func addSkill(_ skill: Skill) {
        
    }
}
