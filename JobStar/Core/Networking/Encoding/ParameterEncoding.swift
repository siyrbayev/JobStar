//
//  ParameterEncoding.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

public typealias Parameters = [String : Any]

// MARK: - ParameterEncoderProtocol

public protocol ParameterEncoderProtocol {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
