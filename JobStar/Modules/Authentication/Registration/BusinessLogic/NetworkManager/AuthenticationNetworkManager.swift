//
//  RegistrationNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import Foundation

protocol AuthenticationNetworkManagerProtocol {
    
    func cancel()
    
    func register(parameters: Parameters, completion: @escaping (_ registrationResponseModel: RegisterResponseModel?, _ error: String?) -> Void)
    func login(parameters: Parameters, completion: @escaping (_ successResponse: SuccessLoginResponseModel?, _ failResponse: FailLoginResponseModel?, _ error: String?) -> Void)
    func checkUsername(string: String, completion: @escaping (Bool?, String?) -> Void)
    
}

class AuthenticationNetworkManager: NetworkManagerProtocol {
    
    static let shared = AuthenticationNetworkManager()
    
    private let router: Router<AuthenticationEndpoints> = Router<AuthenticationEndpoints>()
}

extension AuthenticationNetworkManager: AuthenticationNetworkManagerProtocol {
    
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
    
    func login(parameters: Parameters, completion: @escaping (_ successResponse: SuccessLoginResponseModel?, _ failResponse: FailLoginResponseModel?, _ error: String?) -> Void) {
        
        router.request(.login(bodyParameters: parameters)) { [weak self] data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, nil, "Please check your network connection")
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, nil, NetworkResponse.noResponse.rawValue)
                }
                return
            }
            guard let responseData = data else {
                DispatchQueue.main.async {
                    completion(nil, nil, NetworkResponse.noData.rawValue)
                }
                return
            }
            
            let result = self?.handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let successResponse = try JSONDecoder().decode(SuccessLoginResponseModel.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(successResponse, nil, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
            case .failure(let errorString):
                do {
                    let failResponse = try JSONDecoder().decode(FailLoginResponseModel.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(nil, failResponse, errorString)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
                DispatchQueue.main.async {
                    completion(nil, nil, errorString)
                }
            case .none:
                DispatchQueue.main.async {
                    completion(nil, nil, NetworkResponse.failed.rawValue)
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
