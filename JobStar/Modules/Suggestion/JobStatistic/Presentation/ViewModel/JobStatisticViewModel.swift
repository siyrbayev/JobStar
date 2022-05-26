//
//  JobStatisticViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import Foundation

protocol JobStatisticViewModelProtocol {
    
    func getExperience(with parameters: Parameters)
    func getAnalyzedVacacncies(with paramaters: Parameters)
}

final class JobStatisticViewModel: ObservableObject {
    
    private let networkManager: JobStatisticNetworkManagerProtocol!
    
    // MARK: - Published
    
    @Published var isJobStatisticLoading: Bool = false
    @Published var isVacancyListLoading: Bool = false
    @Published var isSearchWasSuccess: Bool = false
    
    @Published var jobAverageSalary: JobAverageSalary = JobAverageSalary(name: nil, data: nil)
    @Published var vacancies: [Vacancy] = []
    
    @Published var wordToFind: String = ""
    @Published var cityNameToSearch: String = ""
    @Published var cities: [City] = []
    
    @Published var city: City = City(id: "159", parentId: "40", name: "Нур-Султан", areas: []) {
        didSet {
            if !wordToFind.isEmpty { search() }
        }
    }
        
    
    init() {
        networkManager = JobStatisticNetworkManager()
        getCities()
    }
    
    func onAppear() {

    }
}

extension JobStatisticViewModel: JobStatisticViewModelProtocol {
    
    func getExperience(with parameters: Parameters) {
        networkManager.getExperience(parameters: parameters) { [weak self] responseModel, error in
            defer {
                self?.isJobStatisticLoading = false
            }
            
            if let error = error {
                print(error)
            }
            
            guard let responseModel = responseModel else {
                return
            }
            
            self?.isSearchWasSuccess = true
            self?.jobAverageSalary = responseModel
            self?.vacancies = [Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock(), Vacancy.mock()]
        }
    }
    
    func getAnalyzedVacacncies(with paramaters: Parameters) {
        networkManager.getAnalyzedVacancies(parameters: paramaters) { [weak self] responseModel, error in
            defer {
                self?.isVacancyListLoading = false
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

// MARK: - Public funcc

extension JobStatisticViewModel {
    
    func search() {
        isJobStatisticLoading = true
        isVacancyListLoading = true
        guard let id = city.id, let cityId = Int(id)  else {
            isJobStatisticLoading = false
            isVacancyListLoading = false
            return
        }
        
        var skills: [String] = []

        AppData.applicant.skills?.forEach({
            if let skill = $0.skill {
                skills.append(skill as String)
            }
        })
        
        let averageSalaryRequestModel = JobAverageSalaryRequestModel(area: cityId, wordToFind: wordToFind)

        let vacancyRequestModel = AnalyzedVacanciesRequestModel(area: Int(cityId), wordToFind: wordToFind, skillSet: skills, page: 0, itemsPerPage: 20)
        
        var vacancyParameters: Parameters = [:]
        var averageSalaryParameters: Parameters = [:]
        
        do {
            averageSalaryParameters = try DictionaryEncoder().encode(averageSalaryRequestModel)
            vacancyParameters = try DictionaryEncoder().encode(vacancyRequestModel)
        } catch {
            print(error.localizedDescription)
            isJobStatisticLoading = false
            isVacancyListLoading = false
            return
        }
        
        getExperience(with: averageSalaryParameters)
        getAnalyzedVacacncies(with: vacancyParameters)
    }
    
    func setCity(_ city: City) {
        self.city = city
    }
    
    func getCities() {
        guard let cities = loadJson(with: "40") else {
            return
        }
        self.cities = cities
    }
    
    func eraseData() {
        wordToFind = ""
        cityNameToSearch = ""
        isSearchWasSuccess = false
        jobAverageSalary = JobAverageSalary(name: nil, data: nil)
        vacancies = []
    }
}

// MARK: - Private funcc

private extension JobStatisticViewModel {
    
    
}

func loadJson(with fileName: String) -> [City]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Country.self, from: data)
            return jsonData.areas
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
