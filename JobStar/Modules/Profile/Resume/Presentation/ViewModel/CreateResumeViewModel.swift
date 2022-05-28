//
//  CreateResumeViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation
import SwiftUI

fileprivate protocol CreateResumeViewModelProtocol {
    
    func createResume(parameters: Parameters)
}

// MARK: - CreateResumeViewModel

final class CreateResumeViewModel: ObservableObject {
    
    private let networkManager: ResumeNetworkManagerProtocol
    
    // MARK: - Published
    
    @Published var isAllSkillsPresented: Bool = false
    @Published var isPresented: Bool = false
    @Published var isLoading: Bool = false
    
    // new Reusme properties
    @Published var title: String = ""
    @Published var firstName: String = ""
    @Published var secondName: String = ""
    @Published var totalWorkExperience: Int = 0
    @Published var description: String = ""
    @Published var mobilePhone: String = ""
    @Published var email: String = ""
    @Published var createdDateTime: String = ""
    @Published var skills: [Skill] = []
    @Published var workTimePeriods: [WorkTimePeriods] = []
    //
    
    @Published var positionName: String = ""
    @Published var beginDateTime: Date = Date()
    @Published var endDateTime: Date = Date()
    
    // MARK: - Init
    
    init() {
        networkManager = ResumeNetworkManager()
    }
}

// MARK: - CreateResumeViewModelProtocol

extension CreateResumeViewModel: CreateResumeViewModelProtocol {
    
    func createResume(parameters: Parameters) {
        networkManager.createResume(parameters: parameters) { [weak self] error in
            defer {
                self?.isLoading = false
            }
            if let error = error, !error.isEmpty {
                print(error)
                return
            }
            
            self?.isPresented = false
        }
    }
}

// MARK: - Public func

extension CreateResumeViewModel {
    
    func onCreateResume() {
        guard let applicantId =  AppData.applicant.id else {
            return
        }
        
        isLoading = true
        var parameters: Parameters = [:]
        
        let resume = Resume(applicantId: applicantId, title: title, firstName: firstName, secondName: secondName, totalWorkExperience: totalWorkExperience, description: description, mobilePhone: mobilePhone, email: email, createdDateTime: createdDateTime, skills: skills, workTimePeriods: workTimePeriods)
        
        do {
            parameters = try DictionaryEncoder().encode(resume)
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
        
        createResume(parameters: parameters)
    }
}

// MARK: - Private func

private extension CreateResumeViewModel {
    
    
}
