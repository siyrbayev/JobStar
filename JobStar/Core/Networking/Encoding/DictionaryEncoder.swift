//
//  DictionaryEncoder.swift
//  JobStar
//
//  Created by siyrbayev on 16.05.2022.
//

import Foundation

class DictionaryEncoder {
    
    private let encoder = JSONEncoder()
    
    func encode<T>(_ value: T) throws -> [String: Any] where T : Encodable {
            let data = try encoder.encode(value)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        }
}
