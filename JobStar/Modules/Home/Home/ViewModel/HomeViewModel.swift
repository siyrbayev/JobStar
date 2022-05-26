//
//  HomeViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func getAnalyzedVacacncies(with paramaters: Parameters)
}

final class HomeViewModel: ObservableObject {
    
    private let networkManager: HomeNetworkManagerProtocol!
    
    // MARK: - Published
    
    @Published var isLoading: Bool = false
    @Published var isCityListPresents: Bool = false
    
    @Published var resumes: [Resume] = AppData.applicant.resumes ?? []
    @Published var vacancies: [Vacancy] = []
    @Published var vipVacancies: [Vacancy] = []
    @Published var cities: [City] = []
    
    @Published var wordToFind: String = ""
    @Published var selectedCity: City = City(id: "159", parentId: "40", name: "Нур-Султан", areas: [])
    
    
    // MARK: - Init
    
    init() {
        networkManager = HomeNetworkManager()
    }
    
    func onAppear() {
        
    }
}

// MARK: - Public

extension HomeViewModel {
    
    func setCity(_ city: City) {
        self.selectedCity = city
    }
    
    func getCities() {
        guard let cities = loadJson(with: "40") else {
            return
        }
        self.cities = cities
    }
    
    func onSubmitSearchBar() {
        
//        vipVacancies = [Vacancy.mock(), Vacancy.mock(), Vacancy.mock()]
//
//        vacancies = [Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock()]
//
        isLoading = true

        guard let areaId = selectedCity.id else {
            isLoading = false
            return
        }
        var skills: [String] = []

        AppData.applicant.skills?.forEach({
            if let skill = $0.skill {
                skills.append(skill as String)
            }
        })

        let requestModel = AnalyzedVacanciesRequestModel(area: Int(areaId), wordToFind: wordToFind, skillSet: skills, page: 0, itemsPerPage: nil)

        var parameters: Parameters = [:]

        do {
            parameters = try DictionaryEncoder().encode(requestModel)
        } catch {
            isLoading = false
            print(error.localizedDescription)
        }
        guard !parameters.isEmpty else {
            print("Parameters empty")
            isLoading = false
            return
        }
        parameters.forEach { key, value in
            print(key)
            print(value)
        }

        getAnalyzedVacacncies(with: parameters)
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func getAnalyzedVacacncies(with paramaters: Parameters) {
        networkManager.getAnalyzedVacancies(parameters: paramaters) { [weak self] responseModel, error in
            defer {
                self?.isLoading = false
            }
            
            if let error = error {
                print(error)
            }
            
            guard let responseModel = responseModel,
                  let vacancies = responseModel.vacancies
            else {
                return
            }
            
            self?.vacancies = vacancies
        }
    }
}

// MARK: - Private func

private extension HomeViewModel {
    
}