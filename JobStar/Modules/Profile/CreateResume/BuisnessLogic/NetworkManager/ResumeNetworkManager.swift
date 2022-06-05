//
//  CreateResumeNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation

protocol ResumeNetworkManagerProtocol {
    
    func createResume(parameters: Parameters, completion: @escaping(_ error: String?) -> Void)
    func deleteResume(with id: String, completion: @escaping(_ error: String?) -> Void)
}

// MARK: - CreateResumeNetworkManager

class ResumeNetworkManager: NetworkManagerProtocol {
    
    static let shared = ResumeNetworkManager()
    
    private let router: Router<ResumeEndpoints> = Router<ResumeEndpoints>()
}

// MARK: - CreateResumeNetworkManagerProtocol

extension ResumeNetworkManager: ResumeNetworkManagerProtocol {
    
    func deleteResume(with id: String, completion: @escaping (String?) -> Void) {
        router.request(.deleteResume(id: id)) { [weak self]  data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion("Please check your network connection")
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(NetworkResponse.noResponse.rawValue)
                }
                return
            }
            
            let result = self?.handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    completion(errorString)
                }
            case .none:
                DispatchQueue.main.async {
                    completion(NetworkResponse.failed.rawValue)
                }
            }
        }
    }
    
    func createResume(parameters: Parameters, completion: @escaping (String?) -> Void) {
        router.request(.createResume(bodyParameters: parameters)) { [weak self]  data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion("Please check your network connection")
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(NetworkResponse.noResponse.rawValue)
                }
                return
            }
            
            let result = self?.handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    completion(errorString)
                }
            case .none:
                DispatchQueue.main.async {
                    completion(NetworkResponse.failed.rawValue)
                }
            }
        }
    }
}
