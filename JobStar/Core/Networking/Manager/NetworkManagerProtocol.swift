//
//  NetworkManagerProtocol.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func handleNetworkResponse(response: HTTPURLResponse) -> Result<String>
}

extension NetworkManagerProtocol {
    
    func handleNetworkResponse(response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
            
        // MARK: - 200...299
            
        case 200...299: return .success
            
        // MARK: - 400...499
         
        case 401: return .failure(NetworkResponse.authenticationError.rawValue)
        case 409: return .failure(NetworkResponse.conflict.rawValue)
        case 400...499: return .failure(NetworkResponse.badRequest.rawValue)
            
        // MARK: - 500...599
         
        case 500...599: return .failure(NetworkResponse.badRequest.rawValue)
            
        // MARK: - 600
         
        case 600: return .failure(NetworkResponse.outdated.rawValue)
            
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
