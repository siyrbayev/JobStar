//
//  DateFormat++.swift
//  JobStar
//
//  Created by siyrbayev on 29.05.2022.
//

import Foundation

extension DateFormatter {
    
    static func dateDecodingStrategy() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
}
