//
//  JobStatisticEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

enum JobStatisticEndpoints {
    case experience(bodyParameters: Parameters?)
    case company(bodyParameters: Parameters?)
    case getAnalyzedVacancies(bodyParameters: Parameters?)
}

extension JobStatisticEndpoints: EndpointTypeProtocol {
    
    var environmentBaseURL: NetworkEnvironment {
        return .analyzer
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL undefined")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .experience(_):
            return "/experience"
        case .company(_):
            return "/company"
        case .getAnalyzedVacancies(_):
            return "/vacancies"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .experience(_):
            return .post
        case .company(_):
            return .post
        case .getAnalyzedVacancies(_):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .experience(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .company(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        case .getAnalyzedVacancies(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
}
