//
//  HTTPTask.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

public typealias HTTPHeaders = [String : String]

// MARK: - HTTPTask

public enum HTTPTask {
    
    case requestString(bodyString: String?)
    
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
