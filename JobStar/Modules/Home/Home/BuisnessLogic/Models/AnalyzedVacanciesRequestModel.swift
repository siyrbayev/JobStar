//
//  AnalyzedVaccanciesRequestModel.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

struct AnalyzedVacanciesRequestModel: Codable {
    let area: Int?
    let wordToFind: String?
    let skillSet: [String]?
    let page: Int?
    let itemsPerPage: Int?
}
