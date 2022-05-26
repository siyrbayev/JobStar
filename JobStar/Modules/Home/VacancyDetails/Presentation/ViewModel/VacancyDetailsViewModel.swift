//
//  VacancyDetailsViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 23.05.2022.
//

import Foundation

final class VacancyDetailsViewModel: ObservableObject {
    
    @Published var vacancy: Vacancy = Vacancy()
    
    func onAppear() {
        
    }
}
