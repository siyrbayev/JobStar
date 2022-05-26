//
//  ExperienceResponseModel.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

struct JobAverageSalary: Codable {
    let name: String?
    let data: [SalaryByJobExperience]?
    
    func getMaxSalary() -> Int {
        data?.max(by: {$0.salary ?? 0 < $1.salary ?? 0})?.salary ?? 0
    }
    
    static func mock() -> Self {
        JobAverageSalary(
            name: "Job mock title",
            data: [SalaryByJobExperience.mock(), SalaryByJobExperience.mock(), SalaryByJobExperience.mock(), SalaryByJobExperience.mock()])
    }
}

struct SalaryByJobExperience: Codable, Hashable {
    let year: String?
    let salary: Int?
    
    static func mock() -> Self {
        SalaryByJobExperience(year: "0-3", salary: Int.random(in: 0...2000000))
    }
}

struct JobAverageSalaryRequestModel: Codable {
    let area: Int?
    let wordToFind: String?
}
