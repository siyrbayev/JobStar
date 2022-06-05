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
    
    private let analyzerNetworkManager = AnalyzerNetworkManager.shared
    private let profileNetworkManager = ApplicantNetworkManager.shared
    
    // MARK: - Published
    
    @Published var isLoading: Bool = false
    @Published var isCityListPresents: Bool = false
    @Published var isFirstAppear: Bool = false
    
    @Published var resumes: [Resume] = AppData.applicant.resumes ?? []
    @Published var vacancies: [Vacancy] = []
    @Published var vipVacancy: Vacancy = Vacancy.mock()
    @Published var vipVacancies: [Vacancy] = []
    @Published var cities: [City] = []
    @Published var cityNameToSearch: String = ""
    @Published var wordToFind: String = ""
    @Published var selectedCity: City = City(id: "159", parentId: "40", name: "Нур-Султан", areas: [])
    @Published var page: Int = 0
    @Published var totalPage: Int = 0
    
    // MARK: - Init
    
    init() {
        resumes = AppData.applicant.resumes ?? []
        getVacancies()
    }
    
    func onAppear() {
        getProfileInfo()
    }
    
    func getProfileInfo() {
        profileNetworkManager.getProfileInfo { [weak self] applicant, error in
            defer {
                self?.isFirstAppear = true
            }
            
            if let error = error {
                print(error)
            }
            
            guard let applicant = applicant else {
                return
            }
            
            AppData.applicant = applicant
            self?.resumes = AppData.applicant.resumes ?? []
        }
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
    
    func getAnalyzedVacacncies(with resume: Resume) {
        guard totalPage >= page else {
            return
        }
        isLoading = true

        guard let areaId = selectedCity.id else {
            isLoading = false
            return
        }
        var skills: [String] = []

        resume.skills?.forEach({
            if let skill = $0.skill {
                skills.append(skill as String)
            }
        })

        let requestModel = AnalyzedVacanciesRequestModel(area: Int(areaId), wordToFind: resumes.first?.title ?? "", skillSet: skills, page: page, itemsPerPage: nil)
        
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

        getAnalyzedVacacncies(with: parameters)
    }
    
    func onSubmitSearchBar() {
        
        guard totalPage >= page else {
            return
        }
        
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

        let requestModel = AnalyzedVacanciesRequestModel(area: Int(areaId), wordToFind: wordToFind, skillSet: skills, page: page, itemsPerPage: nil)
        
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
        
        getAnalyzedVacacncies(with: parameters)
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func getAnalyzedVacacncies(with paramaters: Parameters) {
        analyzerNetworkManager.getAnalyzedVacancies(parameters: paramaters) { [weak self] responseModel, error in
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
            
            self?.totalPage += responseModel.totalPage ?? 0
            self?.vacancies.append(contentsOf: vacancies)
            self?.page += 1
        }
    }
}

// MARK: - Private func

private extension HomeViewModel {
    
    func getVacancies() {
        vipVacancies = [Vacancy.mock()]
        guard totalPage >= page else {
            return
        }
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

        let requestModel = AnalyzedVacanciesRequestModel(area: Int(areaId), wordToFind: AppData.applicant.resumes?.first?.title ?? "", skillSet: skills, page: page, itemsPerPage: nil)
        
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

        getAnalyzedVacacncies(with: parameters)
    }
}
