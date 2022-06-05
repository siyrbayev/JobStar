//
//  CreateResumeViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 27.05.2022.
//

import Foundation
import SwiftUI

fileprivate protocol CreateResumeViewModelProtocol {
    
    func createResume(parameters: Parameters, onSuccess: @escaping () -> Void)
}

// MARK: - CreateResumeViewModel

final class CreateResumeViewModel: ObservableObject {
    
    private let networkManager = ResumeNetworkManager.shared
    
    // MARK: - Published
    
    @Published var isAllSkillsPresented: Bool = false
    @Published var isAddWorkExperiencePresented: Bool = false
    @Published var isPresented: Bool = false
    @Published var isLoading: Bool = false
    
    
    // new Reusme properties
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var mobilePhone: String = ""
    @Published var email: String = ""
    @Published var skills: [Skill] = []
    @Published var workTimePeriods: [WorkTimePeriods] = []
    //
    
    @Published var customSkills: [Skill] = []
    
    @Published var positionName: String = "" {
        didSet {
            isPositionNameInvalid = false
        }
    }
    @Published var isPositionNameInvalid: Bool = false
    
    @Published var beginDateTime: Date = Date()
    @Published var endDateTime: Date = Date()
    
    // MARK: - Init
    
    init() {
//        networkManager = ResumeNetworkManager()
    }
    
    func isCreateResumeValid() -> Bool {
            !title.isEmpty
        && !description.isEmpty && !mobilePhone.isEmpty && !email.isEmpty && !skills.isEmpty
    }
}

// MARK: - CreateResumeViewModelProtocol

extension CreateResumeViewModel: CreateResumeViewModelProtocol {
    
    func createResume(parameters: Parameters, onSuccess: @escaping () -> Void) {
        networkManager.createResume(parameters: parameters) { [weak self] error in
            defer {
                self?.isLoading = false
            }
            if let error = error, !error.isEmpty {
                print(error)
                return
            }
            
            onSuccess()
        }
    }
}

// MARK: - Public func

extension CreateResumeViewModel {
    
    func dismissView(_ onDismissView: (() -> Void )) {
        onDismissView()
    }
    
    func addWorkExperience() {
        if !positionName.isEmpty {
            let beginDate = DateFormatter.dateDecodingStrategy().string(from: beginDateTime)
            let endDate = DateFormatter.dateDecodingStrategy().string(from: endDateTime)
            
            workTimePeriods.append(WorkTimePeriods(positionName: positionName, beginDateTime: beginDate, endDateTime: endDate))
            
            isAddWorkExperiencePresented.toggle()
        }
    }
    
    func onCreateResume(_ onDismissView: @escaping (() -> Void )) {
        isLoading = true
        var parameters: Parameters = [:]
        
        let createdDateTime = DateFormatter.dateDecodingStrategy().string(from: Date())
        
        print(createdDateTime)
        
        let resume = ResumeRequestModel(
            title: title,
            description: description,
            mobilePhone: mobilePhone,
            email: email,
            createdDateTime: createdDateTime,
            skills: skills,
            workTimePeriods: workTimePeriods)
        do {
            parameters = try DictionaryEncoder().encode(resume)
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
        
        print(parameters)
        createResume(parameters: parameters, onSuccess: onDismissView)
    }
}

// MARK: - Private func

private extension CreateResumeViewModel {
    
    
}
