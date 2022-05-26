//
//  EndpointType.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

// MARK: - EndpointTypeProtocol

protocol EndpointTypeProtocol {
    var environmentBaseURL: NetworkEnvironment { get }
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum NetworkEnvironment: String {
#if targetEnvironment(simulator)
    case analyzer = "http://localhost:8001/analyzer/api"
    case backend = "http://localhost:8080/api"
#else
    case analyzer = "http://192.168.0.102:8001/analyzer/api"
    case backend = "http://192.168.0.102:8080/api"
#endif
}
