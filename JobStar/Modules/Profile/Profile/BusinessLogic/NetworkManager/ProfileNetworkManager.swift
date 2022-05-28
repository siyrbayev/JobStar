//
//  ProfileNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 20.05.2022.
//

import Foundation

protocol ProfileNetworkManagerProtocol {
    func getProfileInfo(completion: @escaping(_ applicant: Applicant?, _ error: String?) -> Void)
}

class ProfileNetworkManager: NetworkManagerProtocol {
    
    private let router: Router<PrrofileEndpoints>
    
    init() {
        router = Router<PrrofileEndpoints>()
    }
    
}

extension ProfileNetworkManager: ProfileNetworkManagerProtocol {
    
    func getProfileInfo(completion: @escaping (Applicant?, String?) -> Void) {
        router.request(.profileinfo) { [weak self] data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, "Please check your network connection")
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.noResponse.rawValue)
                }
                return
            }
            guard let responseData = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.noData.rawValue)
                }
                return
            }
            
            let result = self?.handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let response = try JSONDecoder().decode(Applicant.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(response, nil)
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
            case .none:
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.failed.rawValue)
                }
            }
            
        }
    }
}
