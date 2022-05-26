//
//  RegistrationNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import Foundation

protocol RegistrationNetworkManagerProtocol {
    
    func cancel()
    
    func register(parameters: Parameters, completion: @escaping (_ registrationResponseModel: RegisterResponseModel?, _ error: String?) -> Void)
    func checkUsername(string: String, completion: @escaping (Bool?, String?) -> Void)
}

class RegistrationNetworkManager: NetworkManagerProtocol {
    
    private let router: Router<RegistrationEndpoints>
    
    init() {
        router = Router<RegistrationEndpoints>()
    }
}

extension RegistrationNetworkManager: RegistrationNetworkManagerProtocol {
    
    func cancel() {
        router.cancel()
    }
    func register(parameters: Parameters, completion: @escaping (RegisterResponseModel?, String?) -> Void) {
        router.request(.register(bodyParameters: parameters)) { [weak self] data, response, error in
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
                    let registerResponseModel = try JSONDecoder().decode(RegisterResponseModel.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(registerResponseModel, nil)
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
    
    func checkUsername(string: String, completion: @escaping (Bool?, String?) -> Void) {
        router.request(.checkUsername(bodyString: string)) { [weak self] _ , response, error in
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
            
            let result = self?.handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    completion(false, errorString)
                }
            case .none:
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.failed.rawValue)
                }
            }
        }
    }
}
