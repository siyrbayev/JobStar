//
//  JobStatisticNetworkManager.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

protocol JobStatisticNetworkManagerProtocol {
    
    func getExperience(parameters: Parameters, completion: @escaping(_ responseModel: JobAverageSalary?, _ error: String?) -> Void)
    func getCompany(parameters: Parameters, completion: @escaping(_ vacancies: AvarageCompanySalary?, _ error: String?) -> Void)
    func getAnalyzedVacancies(parameters: Parameters, completion: @escaping(_ vacancies: AnalyzedVaccanciesResponseModel?, _ error: String?) -> Void)
}

struct JobStatisticNetworkManager: NetworkManagerProtocol {
    
    private let router: Router<JobStatisticEndpoints>
    
    init() {
        router = Router<JobStatisticEndpoints>()
    }
}

extension JobStatisticNetworkManager: JobStatisticNetworkManagerProtocol {
    
    func getExperience(parameters: Parameters, completion: @escaping (JobAverageSalary?, String?) -> Void) {
        router.request(.experience(bodyParameters: parameters)) { data, response, error in
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
            
            let result = handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let response = try JSONDecoder().decode(JobAverageSalary.self, from: responseData)
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
            }
        }
    }
    
    func getCompany(parameters: Parameters, completion: @escaping (AvarageCompanySalary?, String?) -> Void) {
        router.request(.company(bodyParameters: parameters)) { data, response, error in
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
            
            let result = handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let response = try JSONDecoder().decode(AvarageCompanySalary.self, from: responseData)
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
            }
        }
    }
    
    func getAnalyzedVacancies(parameters: Parameters, completion: @escaping (AnalyzedVaccanciesResponseModel?, String?) -> Void) {
        router.request(.getAnalyzedVacancies(bodyParameters: parameters)) { data, response, error in
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
            
            let result = handleNetworkResponse(response: response)
            
            switch result {
            case .success:
                do {
                    let response = try JSONDecoder().decode(AnalyzedVaccanciesResponseModel.self, from: responseData)
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
            }
        }
    }
}
