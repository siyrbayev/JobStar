//
//  AnalyzedVaccanciesResponseModel.swift
//  JobStar
//
//  Created by siyrbayev on 24.05.2022.
//

import Foundation

struct AnalyzedVaccanciesResponseModel: Codable {
    let vacancies: [Vacancy]?
    let page: Int?
    let totalPage: Int?
    let itemsPerPage: Int?
}
