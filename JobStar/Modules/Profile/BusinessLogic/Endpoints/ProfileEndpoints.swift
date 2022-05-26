//
//  ProfileEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 20.05.2022.
//

import Foundation

enum PrrofileEndpoints {
    
    case profileinfo
}

extension PrrofileEndpoints: EndpointTypeProtocol {
    
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
            
        case .profileinfo:
            return "/applicant"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            
        case .profileinfo:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
            
        case .profileinfo:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            
        case .profileinfo:
            return ["Authorization" : "Bearer \(AppData.jsonWebToken)"]
        }
    }
}
