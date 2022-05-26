//
//  AvarageCompanySalary.swift
//  JobStar
//
//  Created by siyrbayev on 11.05.2022.
//

import Foundation

struct AvarageCompanySalary: Codable {
    let name: String?
    let data: [String: Int]?
}

struct AvarageCompanySalaryRequest: Codable {
    let regionId: String?
    let wordToFind: String?
}
