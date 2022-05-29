//
//  WorkTimePeriods.swift
//  JobStar
//
//  Created by siyrbayev on 22.05.2022.
//

import Foundation

struct WorkTimePeriods: Codable, Identifiable {
    let id: String?
    let positionName: String?
    let beginDateTime: String?
    let endDateTime: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case positionName = "positionName"
        case beginDateTime = "beginDateTime"
        case endDateTime = "endDateTime"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        positionName = try container.decodeIfPresent(String.self, forKey: .positionName)
        beginDateTime = try? container.decode(String.self, forKey: .beginDateTime)
        endDateTime = try? container.decode(String.self, forKey: .endDateTime)
    }
    
    init(positionName: String, beginDateTime: String, endDateTime: String) {
        self.id = ""
        self.positionName = positionName
        self.beginDateTime = beginDateTime
        self.endDateTime = endDateTime
    }
}
