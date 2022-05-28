//
//  HomeView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

// MARK: - Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

struct HomeView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - State
    
    @State private var isSearchBarShown: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if !isSearchBarShown {
                        if viewModel.vacancies.isEmpty {
                            defaultView
                        } else {
                            vacancyList
                        }
                    } else {
                        searchBar
                    }
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Home")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 32, weight: .bold))
                        .isHidden(isSearchBarShown, remove: true)
                    
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
                            .autocapitalization(.none)
                            .disableAutocorrection(false)
                            .frame(width: UIScreen.main.bounds.width * 5/6)
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
            }
        }
    }
    
    var defaultView: some View {
        VStack {
            HStack {
                Text("Search by resume")
                    .foregroundColor(.tx_sc)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
            
            ForEach(viewModel.resumes) { resume in
                HStack {
                    Text(resume.title ?? "")
                        .font(.system(size: 14, weight: .medium))
                        .padding()
                    
                    Spacer()
                }
                .background(
                    Color.bg_sc
                        .cornerRadius(12)
                )
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
    
    var vacancyList: some View {
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
    
    var searchBar: some View {
        VStack(spacing: 0){
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 2, height: 2)
                .background(
                    Color.bg_clear
                )
            
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
                        ForEach(AppData.applicant.resumes ?? []) { resume in
                            Button {
                                viewModel.wordToFind = resume.title ?? ""
                            } label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        Text(resume.title ?? "")
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
            .background(
                LinearGradient(colors: [.bg_off, .bg_clear], startPoint: .top, endPoint: .bottom)
            )
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
