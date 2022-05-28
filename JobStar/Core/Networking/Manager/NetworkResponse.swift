//
//  NetworkResponse.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation

enum NetworkResponse: String {
    case success
    case conflict = "User with this username already exist"
    case authenticationError = "Passowrd or username are incorrect"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case noResponse = "There is no response"
    case unableToDecode = "We could not decode the response."
}
