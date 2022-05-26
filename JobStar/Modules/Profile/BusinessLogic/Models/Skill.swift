//
//  Skill.swift
//  JobStar
//
//  Created by siyrbayev on 23.05.2022.
//

import Foundation

struct Skill: Codable, Identifiable, Equatable {
    let id: String?
    let skill: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case skill = "skill"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        skill = try container.decodeIfPresent(String.self, forKey: .skill)
    }
}
