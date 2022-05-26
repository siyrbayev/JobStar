//
//  LoginEndpoint.swift
//  JobStar
//
//  Created by siyrbayev on 16.05.2022.
//

import Foundation

enum LoginEndpoints {
    case login(bodyParameters: Parameters)
}

extension LoginEndpoints: EndpointTypeProtocol {
    
    var environmentBaseURL: NetworkEnvironment {
        return .backend
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "/authentication/login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .login(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login:
            return nil
        }
    }
}
