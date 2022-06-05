//
//  AnalyzerEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

enum AnalyzerEndpoints {
    case experience(bodyParameters: Parameters?)
    case company(bodyParameters: Parameters?)
    case getAnalyzedVacancies(bodyParameters: Parameters?)
}

extension AnalyzerEndpoints: EndpointTypeProtocol {
    
    var environmentBaseURL: NetworkEnvironment {
        return .backend
    }
    
    var baseURL: URL {
        guard let baseUrl = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL undefined")
        }
        return baseUrl
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
        return ["Authorization" : "Bearer \(AppData.jsonWebToken)"]
    }
}
