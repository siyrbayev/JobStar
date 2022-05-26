//
//  AnalyzerEndpoints.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

enum HomeEndpoints {
    case getAnalyzedVacancies(bodyParameters: Parameters?)
}

extension HomeEndpoints: EndpointTypeProtocol {
    var environmentBaseURL: NetworkEnvironment {
        switch self {
        case .getAnalyzedVacancies(_):
            return .analyzer
        }
    }
    
    var baseURL: URL {
        guard let baseUrl = URL(string: environmentBaseURL.rawValue) else {
            fatalError("baseURL undefined")
        }
        return baseUrl
    }
    
    var path: String {
        switch self {
        case .getAnalyzedVacancies(_):
            return "/vacancies"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAnalyzedVacancies(_):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAnalyzedVacancies(let bodyParameters):
            return .requestParameters(bodyParameters: bodyParameters, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAnalyzedVacancies(_):
            return nil
        }
    }
}
