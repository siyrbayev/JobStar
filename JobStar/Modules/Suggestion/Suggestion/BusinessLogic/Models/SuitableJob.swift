//
//  SuitableJob.swift
//  JobStar
//
//  Created by siyrbayev on 20.03.2022.
//

import Foundation

// This object is a list of 20 objects, sorted by suitable position.
struct SuitableJob: Codable, Identifiable, Hashable {
    var id: Int?
    // Job name or Job
    var name: String?
    // in some point or per cent
    var suitabilityScore: Int?
}


/*
 
User {
    suitableJobs: [SuitableJob]
}
 
 */
