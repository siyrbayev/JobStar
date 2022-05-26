//
//  Country.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import Foundation

struct Country: Codable, Identifiable {
    let id: String?
    let parentId: String?
    let name: String?
    let areas: [City]?
}

extension Country {
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentId = "parent_id"
        case name
        case areas
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(String.self, forKey: .id)
        self.parentId = try? container.decode(String.self, forKey: .parentId)
        self.name = try? container.decode(String.self, forKey: .name)
        self.areas = try? container.decode([City].self, forKey: .areas)
    }
}

