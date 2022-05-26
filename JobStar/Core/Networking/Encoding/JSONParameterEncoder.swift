//
//  JSONParameterEncoder.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

// MARK: - JSONParameterEncoder

public struct JSONParameterEncoder: ParameterEncoderProtocol {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    public static func encode(urlRequest: inout URLRequest, with string: String) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: string, options: .fragmentsAllowed)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
