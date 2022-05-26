//
//  AppManager.swift
//  JobStar
//
//  Created by siyrbayev on 10.04.2022.
//

import Foundation
import Combine

struct AppManager {
    
    static func isAuthenticated() -> Bool {
        UserDefaults.standard.string(forKey: "token") != nil
    }
}
