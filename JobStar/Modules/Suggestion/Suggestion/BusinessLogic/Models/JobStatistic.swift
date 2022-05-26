//
//  JobStatistic.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import Foundation

struct JobStatistic: Codable {
    let name: String?
    let data: [String: Int]?
    
    static func mock() -> JobStatistic {
        return JobStatistic(
            name: "По Нур-Султану по запросу Java такая статистика зарплаты(KZT) на опыт работы",
            data: [
                "0" : 150358,
                "1-3": 398725,
                "3-6": 1430345,
                "6+": 1635333
            ]
        )
    }
}

struct JobStatisticData: Codable, Identifiable {
    let id: Int
    let year: String
    let salary: Int
}

struct JobStatistics: Codable {
    var name: String?
    var data: [JobStatisticData]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        data = try container.decode([JobStatisticData].self, forKey: .data)
    }
    
    init() {}
    
    func getMaxSalary() -> Int {
        data?.max(by: {$0.salary < $1.salary})?.salary ?? 0
    }
    
    static func mock() -> JobStatistics {
        var model = JobStatistics()
        model.data = [
            JobStatisticData(id: 0, year: "0", salary: 150358),
            JobStatisticData(id: 1, year: "1-3", salary: 398725),
            JobStatisticData(id: 2, year: "3-6", salary: 730345),
            JobStatisticData(id: 3, year: "6+", salary: 1235333)
        ]
        model.name = "По Нур-Султану по запросу Java такая статистика зарплаты(KZT) на опыт работы"
        
        return model
    }
}
