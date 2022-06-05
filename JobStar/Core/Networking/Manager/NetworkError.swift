//
//  NetworkError.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: String, Error {
    
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
}
