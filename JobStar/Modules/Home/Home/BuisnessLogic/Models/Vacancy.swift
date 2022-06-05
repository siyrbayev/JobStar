//
//  Vacancy.swift
//  JobStar
//
//  Created by siyrbayev on 20.05.2022.
//

import Foundation

struct Vacancy: Codable, Identifiable {
    var id: Int?
    var name: String?
    var area: String?
    var experience: String?
    var companyName: String?
    var companyLogoUrl: String?
    var salaryFrom: Double?
    var salaryTo: Double?
    var skillSet: [String]?
    var matchBySkillSet: Double?
    var linkToVacancy: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case area = "area"
        case experience = "experience"
        case companyName = "company_name"
        case companyLogoUrl = "company_logo_url"
        case salaryFrom = "salary_from"
        case salaryTo = "salary_to"
        case skillSet = "skill_set"
        case matchBySkillSet = "match_by_skill_set"
        case linkToVacancy = "link_to_vacancy"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        experience = try container.decodeIfPresent(String.self, forKey: .experience)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        companyLogoUrl = try container.decodeIfPresent(String.self, forKey: .companyLogoUrl)
        salaryFrom = try container.decodeIfPresent(Double.self, forKey: .salaryFrom)
        salaryTo = try container.decodeIfPresent(Double.self, forKey: .salaryTo)
        skillSet = try container.decodeIfPresent([String].self, forKey: .skillSet)
        matchBySkillSet = try container.decodeIfPresent(Double.self, forKey: .matchBySkillSet)
        linkToVacancy = try container.decodeIfPresent(String.self, forKey: .linkToVacancy)
    }
    
    init() {}
    
    static func mock() -> Self {
        var vacancy = Vacancy()
        vacancy.id = Int.random(in: 1...1000000)
        vacancy.name = "C# Junior developer, Spring, JDK 16"
        vacancy.area = "Nur-Sultan, Mangilik El 53"
        vacancy.experience = "experience"
        vacancy.companyName = "Microsoft LLC Inc."
        vacancy.companyLogoUrl = "https://notebook-repair.ee/wp-content/uploads/2020/03/logomicrosoftmicrosoftlogotechnologywindowsicon-1320167831167856453.png"
        vacancy.salaryFrom = 1000000
        vacancy.salaryTo = 1200000
        vacancy.skillSet = ["ASP .NET", "REST API", "Design Patterns", "Docker"]
        vacancy.matchBySkillSet = Double.random(in: 80...100)
        vacancy.linkToVacancy = "link_to_vacancy"
        
        return vacancy
    }
}
