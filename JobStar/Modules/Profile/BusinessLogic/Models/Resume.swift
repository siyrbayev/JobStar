//
//  Resume.swift
//  JobStar
//
//  Created by siyrbayev on 22.05.2022.
//

import Foundation

struct Resume: Codable, Identifiable {
    let id: String?
    let applicantId: String?
    let title: String?
    let firstName: String?
    let secondName: String?
    let totalWorkExperience: Int?
    let description: String?
    let mobilePhone: String?
    let email: String?
    let createdDateTime: String?
    let skills: [Skill]?
    let workTimePeriods: [WorkTimePeriods]?
    let totalWorkTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case applicantId = "applicantId"
        case title = "title"
        case firstName = "firstName"
        case secondName = "secondName"
        case totalWorkExperience = "totalWorkExperience"
        case description = "description"
        case mobilePhone = "mobilePhone"
        case email = "email"
        case createdDateTime = "createdDateTime"
        case skills = "skills"
        case workTimePeriods = "workTimePeriods"
        case totalWorkTime = "totalWorkTime"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        applicantId = try container.decodeIfPresent(String.self, forKey: .applicantId)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        secondName = try container.decodeIfPresent(String.self, forKey: .secondName)
        totalWorkExperience = try container.decodeIfPresent(Int.self, forKey: .totalWorkExperience)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        mobilePhone = try container.decodeIfPresent(String.self, forKey: .mobilePhone)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        createdDateTime = try? container.decode(String.self, forKey: .createdDateTime)
        skills = try container.decodeIfPresent([Skill].self, forKey: .skills)
        workTimePeriods = try container.decodeIfPresent([WorkTimePeriods].self, forKey: .workTimePeriods)
        totalWorkTime = try? container.decode(Double.self, forKey: .totalWorkTime)
    }
    
    static func mock() -> Self? {
        let jsonResume = """
        {
                    "id": "\(UUID())",
                    "workTimePeriods": [
                        {
                            "id": "1aa0a7d6-e47c-4995-7aab-08da3ceb7a6e",
                            "positionName": "C# Junior Developer",
                            "beginDateTime": "22/02/2021",
                            "endDateTime": "02/01/2022"
                        },
                        {
                            "id": "5ac6feae-8025-422e-7aac-08da3ceb7a6e",
                            "positionName": "C# Middle Developer",
                            "beginDateTime": "12/01/2022",
                            "endDateTime": "23/05/2022"
                        }
                    ],
                    "skills": [
                        {
                            "id": "669b21d1-fa08-48be-93b4-6337cce7d002",
                            "skill": "REST API"
                        },
                        {
                            "id": "9102ae41-7b9e-4495-b6e1-6a816f5d0e5f",
                            "skill": "ASP .NET"
                        },
                        {
                            "id": "a9ff3671-4730-416e-8f75-a110643ef946",
                            "skill": "C#"
                        },
                        {
                            "id": "681a4fd1-57b4-4feb-90b9-aed0f79a81ff",
                            "skill": "Docker"
                        }
                    ],
                    "description": "I am Middle C# Developer. ",
                    "mobilePhone": "8729482494",
                    "email": "middle_c_sharp_dev@gmail.com",
                    "title": "Middle C# Developer",
                    "createdDateTime": "Monday, 23 May 2022 09:39",
                    "applicantId": "87b28d1f-75f7-4b9e-5006-08da3cea1919",
                    "totalWorkTime": -1.2191780821917808
                }
        """
        let data = Data(jsonResume.utf8)
        
        do {
            return try JSONDecoder().decode(Resume.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
