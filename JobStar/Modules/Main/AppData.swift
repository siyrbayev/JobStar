//
//  AppData.swift
//  JobStar
//
//  Created by siyrbayev on 16.05.2022.
//

import Foundation
import SwiftUI

struct AppData {

    @AppStorage("isAuthenticated")
    static var isAuthenticated: Bool = false
    
    @AppStorage("isFirstLaunch")
    static var isFirstLaunch: Bool = true
    
    @AppStorage("username")
    static var username: String = ""
    
    @AppStorage("jsonWebToken")
    static var jsonWebToken: String = ""
    
    @DataStorage(key: "user_key", defaultValue: Applicant())
    static var applicant: Applicant
}

