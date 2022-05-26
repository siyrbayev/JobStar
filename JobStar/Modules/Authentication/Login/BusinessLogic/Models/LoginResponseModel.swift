//
//  LoginResponseModel.swift
//  JobStar
//
//  Created by siyrbayev on 16.05.2022.
//

import Foundation

struct SuccessLoginResponseModel: Codable {
    let token: String?
    let expiration: String?
    
    private enum CodingKeys: String, CodingKey {
        case token
        case expiration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.token = try? container.decode(String.self, forKey: .token)
        self.expiration = try? container.decode(String.self, forKey: .expiration)
    }
}

struct FailLoginResponseModel: Codable {

    let type: String?
    let title: String?
    let status: Int?
    let traceId: String?
    let errors: Errors?

    struct Errors: Codable {
        let Username: [String]?
        let Password: [String]?
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case title
        case status
        case traceId
        case errors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try? container.decode(String.self, forKey: .type)
        self.title = try? container.decode(String.self, forKey: .title)
        self.status = try? container.decode(Int.self, forKey: .status)
        self.traceId = try? container.decode(String.self, forKey: .traceId)
        self.errors = try? container.decode(Errors.self, forKey: .errors)
    }
    
}

