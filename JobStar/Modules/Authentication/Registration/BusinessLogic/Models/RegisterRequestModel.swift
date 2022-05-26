//
//  RegisterRequestModel.swift
//  JobStar
//
//  Created by siyrbayev on 18.05.2022.
//

import Foundation

struct RegisterRequestModel: Codable {
    let firstName: String
    let secondName: String
    let username: String
    let email: String
    let password: String
}
