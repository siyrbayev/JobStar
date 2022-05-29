//
//  AvarageCompanySalary.swift
//  JobStar
//
//  Created by siyrbayev on 11.05.2022.
//

import Foundation

struct AvarageCompanySalaryData: Codable, Identifiable, Hashable {
    let id: String?
    let companyName: String?
    let salary: Int?
    
    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case salary
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID().uuidString
        companyName = try? container.decode(String.self, forKey: .companyName)
        salary = try? container.decode(Int.self, forKey: .salary)
    }
}

struct AvarageCompanySalary: Codable {
    var name: String?
    var data: [AvarageCompanySalaryData]?
    
    func getMaxSalary() -> Int {
        data?.max(by: {$0.salary ?? 0 < $1.salary ?? 0})?.salary ?? 0
    }
    
    init() {}
}
