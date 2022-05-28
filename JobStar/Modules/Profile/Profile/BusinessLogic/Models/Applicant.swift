//
//  Applicant.swift
//  JobStar
//
//  Created by siyrbayev on 23.05.2022.
//

import Foundation

struct Applicant: Codable {
    var id: String?
    var firstName: String?
    var secondName: String?
    var email: String?
    var profilePhoto: String?
    var mobilePhone: String?
    var resumes: [Resume]?
    var skills: [Skill]?
    var about: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case secondName = "secondName"
        case email = "email"
        case profilePhoto = "profilePhoto"
        case mobilePhone = "mobilePhone"
        case resumes = "resumes"
        case skills = "skills"
        case about = "about"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        firstName = try container.decode(String.self , forKey: .firstName)
        secondName = try container.decode(String.self , forKey: .secondName)
        email = try container.decode(String.self , forKey: .email)
        profilePhoto = try container.decodeIfPresent(String.self , forKey: .profilePhoto)
        mobilePhone = try container.decodeIfPresent(String.self , forKey: .mobilePhone)
        resumes = try container.decodeIfPresent([Resume].self, forKey: .resumes)
        skills = try container.decodeIfPresent([Skill].self, forKey: .skills)
        about = try container.decodeIfPresent(String.self, forKey: .about)
    }
    
    init() {}
}
