//
//  CreateResumeEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation

enum ResumeEndpoints {
    case createResume(bodyParameters: Parameters)
}

extension ResumeEndpoints: EndpointTypeProtocol {
    
    var environmentBaseURL: NetworkEnvironment {
        .backend
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL could not be configured.")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .createResume(_):
            return "/resume"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createResume(_):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .createResume(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .createResume(_):
            return ["Authorization" : "Bearer \(AppData.jsonWebToken)"]
        }
    }
}
