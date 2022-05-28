//
//  SkillEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 28.05.2022.
//

import Foundation

enum SkillEndpoints {
    case getAllSkills
}

extension SkillEndpoints: EndpointTypeProtocol {
    
    var environmentBaseURL: NetworkEnvironment {
        switch self {
        case .getAllSkills:
            return .backend
        }
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL could not be configured.")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getAllSkills:
            return "/skill/all"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllSkills:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllSkills:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAllSkills:
            return ["Authorization" : "Bearer \(AppData.jsonWebToken)"]
        }
    }
}
