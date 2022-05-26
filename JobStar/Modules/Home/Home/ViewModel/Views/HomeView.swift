//
//  HomeView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

struct HomeView: View {
    
    enum Field {
        case name
    }
    
    @FocusState private var focusedField: Field?
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var searchable: String = ""
    
    @State private var isFocused: Bool = false
    @State private var isSearchBarShown: Bool = false
    
    func configureViewModel(with vacancy: Vacancy, viewModel: VacancyDetailsViewModel) -> VacancyDetailsViewModel {
        viewModel.vacancy = vacancy
        return viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if !isSearchBarShown {
                        if viewModel.vacancies.isEmpty {
                            VStack {
//                                HStack(alignment: .top) {
//                                    Spacer()
//                                    Text("Search for vacancy")
//                                        .foregroundColor(.tx_sc)
//                                        .font(.system(size: 18, weight: .medium))
//                                        .padding(.vertical)
//
//                                    Image(systemName: "line.diagonal.arrow")
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                        .foregroundColor(.tx_sc)
//                                        .padding(.trailing, 54)
//                                }
//                                .padding(.top, 4)
                                
                                HStack {
                                    Text("Search by resume")
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.horizontal)
                                    
                                    Spacer()
                                }
                                
                                ForEach(viewModel.resumes) { resume in
                                    HStack {
                                        Text(resume.title ?? "")
                                            .padding()
                                        
                                        Spacer()
                                    }
                                    .background(Color.bg_sc.cornerRadius(12))
                                    .padding(.horizontal)
                                }
                                
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                VStack {
                                    ForEach(viewModel.vipVacancies) { vacancy in
                                        NavigationLink {
                                            VacancyDetailsView(vacancy: vacancy)
                                        } label: {
                                            VacancyRowItemView(isVIP: true, vacancy: vacancy)
                                                .padding(.horizontal)
                                        }
                                    }
                                    
                                    ForEach(viewModel.vacancies) { vacancy in
                                        NavigationLink {
                                            VacancyDetailsView(vacancy: vacancy)
                                        } label: {
                                            VacancyRowItemView(isVIP: false, vacancy: vacancy)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    } else {
                        VStack(spacing: 0) {
                            HStack {
                                Text("Search by resume")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.tx_sc)
                                
                                Spacer()
                            }
                            .padding([.horizontal, .top])
                            
                            ScrollView {
                                VStack(spacing: 8) {
                                    ForEach(AppData.applicant.skills ?? []) { skill in
                                        Button {
                                            viewModel.wordToFind = skill.skill ?? ""
                                        } label: {
                                            VStack(spacing: 0) {
                                                HStack {
                                                    Text(skill.skill ?? "")
                                                        .font(.system(size: 14, weight: .regular))
                                                    Spacer()
                                                }
                                                .foregroundColor(.tx_pr)
                                                .padding(.vertical, 6)
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
//                        List {
//                            Section("Search by resume") {
//                                ForEach(viewModel.resumes) { resume in
//                                    Text(resume.title ?? "")
//                                }
//                            }
//                        }
//                        .background(Color.bg_clear)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                            Text("Home")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 32, weight: .bold))
                                .isHidden(isSearchBarShown, remove: true)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: toggleSearchBar) {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .isHidden(!isSearchBarShown, remove: true)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        HStack(spacing: 0) {
                            HStack {
                                CustomUITextField(placeHolder: "Search", text: $viewModel.wordToFind, isFirstResponder: true, shouldReturn: {
                                    viewModel.onSubmitSearchBar()
                                    isSearchBarShown.toggle()
                                })
                                .frame(width: UIScreen.main.bounds.width * 2/3)
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 16, weight: .medium))
                            }
                            
                            Spacer()
                        }
                        .isHidden(!isSearchBarShown, remove: true)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: toggleSearchBar) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.tx_pr)
                        }
                        .isHidden(isSearchBarShown, remove: true)
                    }
                    
//                    ToolbarItem(placement: .principal) {
//                        if isSearchBarShown {
//                            HStack {
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(.tx_sc)
//
//                                    TextField("Search", text: $viewModel.wordToFind)
//                                        .focused($focusedField, equals: Field.name)
//                                        .onSubmit {
//                                            viewModel.onSubmitSearchBar()
//                                            isSearchBarShown.toggle()
//                                        }
//                                        .foregroundColor(.tx_pr)
//                                        .font(.system(size: 16, weight: .medium))
//                                }
//                                .background(
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .stroke(Color.tx_sc, lineWidth: 0.5)
//                                        .blur(radius: 2)
//                                        .padding(.horizontal, -8)
//                                        .frame(height: 40)
//                                        .background(
//                                            Color.bg_sc
//                                                .cornerRadius(12)
//                                        )
//                                )
//
//                                Spacer()
//                            }
//                        }
//                    }
                }
                ProgressView()
                    .font(.largeTitle)
                    .frame(width: 48, height: 48, alignment: .center)
                    .padding()
                    .background(Color.bg_clear)
                    .cornerRadius(6)
                    .isHidden(!viewModel.isLoading, remove: true)
            }
            .disabled(viewModel.isLoading)
        }
    }
}


// MARK: - Private func

private extension HomeView {
    
    func onSubmitSearchBar() {
        viewModel.onSubmitSearchBar()
    }
    
    func toggleSearchBar() {
        withAnimation(.easeIn(duration: 0.1)) {
            isSearchBarShown.toggle()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
