//
//  SkillNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import Foundation

protocol SkillNetworkManagerProtocol {
    
    func getAllSkills(completion: @escaping(_ skills: [Skill]?,_ error: String?) -> Void)
}

// MARK: - CreateResumeNetworkManager

struct SkillNetworkManager: NetworkManagerProtocol {
    
    private var router: Router<SkillEndpoints>
    
    init() {
        router = Router<SkillEndpoints>()
    }
}

// MARK: - CreateResumeNetworkManagerProtocol

extension SkillNetworkManager: SkillNetworkManagerProtocol {
    
    func getAllSkills(completion: @escaping ([Skill]?, String?) -> Void) {
        router.request(.getAllSkills) { data , response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, "Please check your network connection")
                }
                return
            }
            guard let jsonData = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.noData.rawValue)
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.noResponse.rawValue)
                }
                return
            }
            
            let result = handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let skills: [Skill] = try JSONDecoder().decode([Skill].self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(skills, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    completion(nil, errorString)
                }
            }
        }
    }
    
}
