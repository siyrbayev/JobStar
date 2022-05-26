//
//  SuggestionViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import Foundation

final class SuggestionViewModel: ObservableObject {
    
    @Published var suitableJobs: [SuitableJob] = []
    
    var topSuitableJob: [SuitableJob] {
        guard let job = suitableJobs.first else { return [] }
        return [job]
    }
        
    func onAppear() {
        suitableJobs = [
        SuitableJob(id: 0, name: "IOS Developer", suitabilityScore: 100),
        SuitableJob(id: 1, name: "Android developer", suitabilityScore: 88),
        SuitableJob(id: 2, name: "Flutter Developer", suitabilityScore: 5)
        ]
    }
}
