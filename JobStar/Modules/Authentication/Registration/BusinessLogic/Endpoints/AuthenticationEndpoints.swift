//
//  RegistrationEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 17.05.2022.
//

import Foundation

enum AuthenticationEndpoints {
    case register(bodyParameters: Parameters)
    case login(bodyParameters: Parameters)
    case checkUsername(bodyString: String)
}

extension AuthenticationEndpoints: EndpointTypeProtocol {
    
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
        case .register:
            return "/register"
        case .login:
            return "/login"
        case .checkUsername:
            return "/checkusername"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .checkUsername:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .register(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .login(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .checkUsername(let bodyString):
            return .requestString(bodyString: bodyString)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .register:
            return nil
        case .login:
            return nil
        case .checkUsername(_):
            return nil
        }
    }
}
