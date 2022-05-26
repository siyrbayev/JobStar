//
//  User.swift
//  JobStar
//
//  Created by siyrbayev on 20.05.2022.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String?
    let firstName: String?
    let secondName: String?
    let email: String?
    let username: String?
    let profilePhoto: String?
    let mobilePhone: String?
    let birthDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "userId"
        case firstName = "firstName"
        case secondName = "secondName"
        case email = "email"
        case username = "username"
        case profilePhoto = "profilePhoto"
        case mobilePhone = "mobilePhone"
        case birthDate = "birthDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self , forKey: .firstName)
        secondName = try container.decodeIfPresent(String.self , forKey: .secondName)
        email = try container.decodeIfPresent(String.self , forKey: .email)
        username = try container.decodeIfPresent(String.self , forKey: .username)
        profilePhoto = try container.decodeIfPresent(String.self , forKey: .profilePhoto)
        mobilePhone = try container.decodeIfPresent(String.self , forKey: .mobilePhone)
        birthDate = try container.decodeIfPresent(String.self, forKey: .birthDate)
    }
}
