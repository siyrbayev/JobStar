//
//  LoginNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation



protocol LoginNetworkManagerProtocol {
    
    func login(parameters: Parameters, completion: @escaping (_ successResponse: SuccessLoginResponseModel?, _ failResponse: FailLoginResponseModel?, _ error: String?) -> Void)
}

class LoginNetworkManager: NetworkManagerProtocol {
    
    private let router: Router<LoginEndpoints>
    
    init() {
        router = Router<LoginEndpoints>()
    }
    
}

// MARK: - LoginNetworkManagerProtocol

extension LoginNetworkManager: LoginNetworkManagerProtocol {
    
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
    
    //    func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: String?) -> Void) {
    //        router.request(.newMovies(page: page)) { data, response, error in
    //            guard error == nil else {
    //                completion(nil, "Please check your network connection")
    //                return
    //            }
    //            guard let response = response as? HTTPURLResponse else {
    //                completion(nil, NetworkResponse.noResponse.rawValue)
    //                return
    //            }
    //
    //            let result = handleNetworkResponse(response: response)
    //
    //            switch result {
    //            case .success:
    //                guard let responseData = data else {
    //                    completion(nil, NetworkResponse.noData.rawValue)
    //                    return
    //                }
    //                do {
    //                    let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
    //                    completion(apiResponse.movies, nil)
    //                } catch {
    //                    completion(nil, NetworkResponse.unableToDecode.rawValue)
    //                }
    //            case .failure(let errorString):
    //                completion(nil, errorString)
    //            }
    //        }
    //    }
}
