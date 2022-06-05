//
//  CompanySalaryStatisticViewModel.swift
//  JobStar
//
//  Created by siyrbayev on 03.05.2022.
//

import Foundation

protocol CompanySalaryStatisticViewModelProtocol {
    
    func getCompany(with parameters: Parameters)
}

final class CompanySalaryStatisticViewModel: ObservableObject {
    
    private let networkManager = AnalyzerNetworkManager.shared
    
    // MARK: - Published
    
    @Published var isJobStatisticLoading: Bool = false
    @Published var isVacancyListLoading: Bool = false
    @Published var isSearchWasSuccess: Bool = false
    
    @Published var avarageCompanySalary: AvarageCompanySalary = AvarageCompanySalary()
    
    @Published var wordToFind: String = ""
    @Published var cityNameToSearch: String = ""
    @Published var cities: [City] = []
    
    @Published var city: City = City(id: "159", parentId: "40", name: "Нур-Султан", areas: [])
    
    init() {
        getCities()
    }
    
}

extension CompanySalaryStatisticViewModel: CompanySalaryStatisticViewModelProtocol {
    
    func getCompany(with parameters: Parameters) {
        networkManager.getCompany(parameters: parameters) { [weak self] responseModel, error in
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
            self?.avarageCompanySalary = responseModel
        }
    }
}

// MARK: - Public func

extension CompanySalaryStatisticViewModel {
    
    func search() {
        isJobStatisticLoading = true
//        isVacancyListLoading = true
        
        guard let id = city.id, let cityId = Int(id)  else {
            isJobStatisticLoading = false
//            isVacancyListLoading = false
            return
        }
        
        var skills: [String] = []

        AppData.applicant.skills?.forEach({
            if let skill = $0.skill {
                skills.append(skill as String)
            }
        })
        
        let averageSalaryRequestModel = JobAverageSalaryRequestModel(area: cityId, wordToFind: wordToFind)
        
        var averageSalaryParameters: Parameters = [:]
        
        do {
            averageSalaryParameters = try DictionaryEncoder().encode(averageSalaryRequestModel)
        } catch {
            print(error.localizedDescription)
            isJobStatisticLoading = false
            isVacancyListLoading = false
            return
        }
        
        getCompany(with: averageSalaryParameters)
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
        avarageCompanySalary = AvarageCompanySalary()
    }
}

// MARK: - Private func

private extension CompanySalaryStatisticViewModel {
    
    
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
