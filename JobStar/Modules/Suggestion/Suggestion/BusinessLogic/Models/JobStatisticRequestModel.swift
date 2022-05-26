//
//  JobStatisticRequestModel.swift
//  JobStar
//
//  Created by siyrbayev on 21.05.2022.
//

import Foundation

struct JobStatisticRequestModel: Codable {
    let regionId: Int?
    let wordToFind: String?
}
