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
        HomeView(tabSelection: .constant(TabBarItemTags.home.rawValue))
//            .preferredColorScheme(.dark)
    }
}

struct HomeView: View {
    
    // MARK: - Binding
    
    @Binding var tabSelection: Int
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - State
    
    @State private var isSearchBarShown: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if (AppData.applicant.resumes ?? []).isEmpty {
                        VStack {
                            Spacer()
                            Image(systemName: "doc.text.image")
                                .padding(20)
                                .foregroundColor(.accent_pr)
                                .imageScale(.large)
                                .font(.system(size: 64))
                                .background(
                                    LinearGradient(
                                        colors: [.bg_off, .bg_clear, .bg_off, .bg_clear],
                                        startPoint: .center,
                                        endPoint: .topLeading)
                                    .blur(radius: 4)
                                )
                                .cornerRadius(12)
                                .padding(.bottom)
                                .shadow(color: Color.tx_sc.opacity(0.4), radius: 64, x: 4, y: 6)
                                .shadow(color: Color.accent_pr.opacity(0.15), radius: 64, x: -6, y: -6)
                            
                            
                            Spacer()
                            Text("Please create resume to find vacancies")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.tx_pr)
                                .padding([.bottom, .horizontal])
                            
                            Button {
                                tabSelection = TabBarItemTags.profile.rawValue
                            } label: {
                                Text("Create resume")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 36)
                                    .padding(.vertical, 18)
                                    .background(Color.lb_pr)
                                    .cornerRadius(12)
                            }
                            Spacer()
                        }
                    } else {
                        if !isSearchBarShown {
                            if viewModel.vacancies.isEmpty {
                                defaultView
                                    .isBlur(viewModel.isLoading, radius: 4)
                            } else {
                                vacancyList
                            }
                        } else {
                            searchBar
                        }
                    }
                }
                .isHidden(!viewModel.isFirstAppear)
                .onAppear {
                    viewModel.onAppear()
                }
                
                ProgressView()
                    .font(.largeTitle)
                    .frame(width: 48, height: 48, alignment: .center)
                    .padding()
                    .background(Color.bg_sc)
                    .cornerRadius(6)
                    .isHidden(!viewModel.isLoading || viewModel.page != 0, remove: true)
            }
            .onAppear { 
                viewModel.onAppear()
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
                                viewModel.vacancies = []
                                viewModel.page = 0
                                viewModel.totalPage = 0
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
                    .isHidden((AppData.applicant.resumes ?? []).isEmpty, remove: true)
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
            LazyVStack {
                ForEach(viewModel.vipVacancies) { vacancy in
                    NavigationLink {
                        VacancyDetailsView(vacancy: vacancy)
                    } label: {
                        VacancyRowItemView(isVIP: true, vacancy: vacancy)
                            .padding(.horizontal)
                    }
                }
                
                ForEach(viewModel.vacancies.indices, id: \.self ) { index in
                    let item = viewModel.vacancies[index]
                    NavigationLink {
                        VacancyDetailsView(vacancy: item)
                    } label: {
                        VacancyRowItemView(isVIP: false, vacancy: item)
                            .padding(.horizontal)
                            .onAppear {
                                if !viewModel.isLoading {
                                    if index == viewModel.vacancies.count - 2 {
                                        onSubmitSearchBar()
                                    }
                                }
                            }
                    }
                }
                
                ProgressView()
                    .font(.largeTitle)
                    .padding(.vertical)
                    .isHidden(!viewModel.isLoading, remove: true)
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
