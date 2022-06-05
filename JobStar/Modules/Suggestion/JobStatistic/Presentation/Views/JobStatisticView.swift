//
//  JobStatisticView.swift
//  JobStar
//
//  Created by siyrbayev on 02.05.2022.
//

import SwiftUI

// MARK: - Preview

struct JobStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        JobStatisticView()
        //            .preferredColorScheme(.dark)
    }
}

struct JobStatisticView: View {
    
    @FocusState private var focus: Bool
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: JobStatisticViewModel = JobStatisticViewModel()
    
    // MARK: - State
    
    @State private var isSearchBarShown: Bool = true
    @State private var isPresented: Bool = false
    @State private var isVacancyListShownMore: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                searchView
                    .isHidden(!isSearchBarShown, remove: true)
                
                VStack {
                    barChart
                        .disabled(viewModel.isJobStatisticLoading)
                    
                    Spacer()
                    
                    vacancies
                        .disabled(viewModel.isVacancyListLoading)
                }
                .isHidden(isSearchBarShown, remove: true)
                
            }
            .background(Color.bg_clear)
            .isBlur(viewModel.isJobStatisticLoading && viewModel.isVacancyListLoading , radius: 6)
            
            VStack(spacing: 0) {
                Text("Searching")
                    .font(.system(size: 14, weight: .semibold))
                
                ProgressView()
                    .font(.largeTitle)
                    .padding(8)
            }
            .foregroundColor(.tx_sc)
            .padding()
            .background(Color.bg_sc)
            .cornerRadius(6)
            .isHidden(!viewModel.isJobStatisticLoading && !viewModel.isVacancyListLoading, remove: true)
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                JobStatisticSetCityView(cityName: $viewModel.cityNameToSearch, cities: $viewModel.cities, onSetCity: { viewModel.setCity($0)}, isPresented: $isPresented)
                    .navigationTitle("Chose city")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isPresented.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.tx_pr)
                            }
                        }
                    }
            }
            .accentColor(.accent_pr)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if !isSearchBarShown {
                    Button(action: dismissView) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    HStack {
                        if isSearchBarShown {
                            Button(action: viewModel.isSearchWasSuccess ? toggleSearchBar : dismissView) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.tx_pr)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .padding(.trailing, -2)
                        }
                        
                        CustomUITextField(placeHolder: "Search", text: $viewModel.wordToFind, isFirstResponder: true, isToolBarShown: false, shouldReturn: {
                            viewModel.vacancies = []
                            viewModel.totalPage = 0
                            viewModel.page = 0
                            onSearch()
                            toggleSearchBar()
                        })
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
                        .foregroundColor(.accent_pr)
                }
                .disabled(viewModel.isVacancyListLoading || viewModel.isJobStatisticLoading)
                .isHidden(isSearchBarShown, remove: true)
            }
        }
    }
    
    // MARK: - SearchView
    
    var searchView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame( width: 2, height: 2)
                .background(Color.bg_clear)
            
            VStack(spacing: 0) {
                Button(action: { isPresented.toggle() }) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Image(systemName: "location.fill")
                                .resizable()
                                .foregroundColor(.accent_pr)
                                .frame(width: 14, height: 14)
                                .padding(.trailing)
                            
                            Text("\(viewModel.city.name ?? "Chose city")")
                                .foregroundColor(.accent_pr)
                                .font(.system(size: 16, weight: .regular))
                                .lineLimit(1)
                                .padding(.vertical, 12)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                    }
                }
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Search by skills:")
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
            }
            .background(
                LinearGradient(colors: [.bg_off, .bg_clear], startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    // MARK: - BarChart
    
    var barChart: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Text(viewModel.jobAverageSalary.name ?? "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.tx_pr)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    
                    Spacer()
                    
                    JobStatisticMiniBarChartView(jobAverageSalary: viewModel.jobAverageSalary, width: 48)
                        .padding([.top, .trailing])
                        .onTapGesture {
                            showMoreVacancies()
                        }
                        .isHidden(!isVacancyListShownMore, remove: true)
                }
                
                JobStatisticBarChartView(jobAverageSalary: viewModel.jobAverageSalary, width: UIScreen.main.bounds.width)
                    .isHidden(isVacancyListShownMore, remove: true)
                
                Divider()
            }
            .isHidden(!viewModel.isSearchWasSuccess, remove: true)
            
            VStack(spacing: 0) {
                ProgressView()
                    .font(.largeTitle)
                    .padding()
            }
            .foregroundColor(.tx_sc)
            .padding()
            .background(Color.bg_sc)
            .cornerRadius(6)
            .isHidden(!(!viewModel.isJobStatisticLoading && viewModel.isVacancyListLoading), remove: true)
        }
    }
    
    // MARK: - Vacancies
    
    var vacancies: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack {
                    ScrollView {
                        VStack {
                            LazyVStack {
                                ForEach (viewModel.vacancies.indices, id: \.self) { index in
                                    let vacancy = viewModel.vacancies[index]
                                    NavigationLink {
                                        VacancyDetailsView(vacancy: vacancy)
                                    } label: {
                                        VacancyRowItemView(isVIP: false, vacancy: vacancy)
                                            .padding(.horizontal)
                                            .onAppear {
                                                if !viewModel.isVacancyListLoading {
                                                    if viewModel.vacancies.count - 2 == index {
                                                        viewModel.searchVacancy()
                                                    }
                                                }
                                            }
                                    }
                                }
                                
                                ProgressView()
                                    .font(.largeTitle)
                                    .padding(.vertical)
                                    .isHidden(!viewModel.isVacancyListLoading, remove: true)
                            }
                            .padding(.bottom, 12)
                            
                            Divider()
                            
                            Text("End of list")
                                .padding(.bottom, -78)
                                .foregroundColor(.tx_sc)
                                .font(.system(size: 14, weight: .regular))
                            
                        }
                        .padding(.bottom, -22)
                        .padding(.top, 64)
                    }
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            Text("Vacancies")
                                .font(.system(size: 22, weight: .bold))
                                .padding(.top, 8)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: showMoreVacancies) {
                                Image(systemName: isVacancyListShownMore ? "arrow.down.forward.and.arrow.up.backward" : "arrow.up.backward.and.arrow.down.forward")
                                    .foregroundColor(.accent_pr)
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.top, 8)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 72, alignment: .top)
                        .background(
                            LinearGradient(colors: [.bg_clear, .bg_clear, .bg_clear, .bg_clear.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                        )
                        
                        Spacer()
                    }
                }
            }
            .isHidden(viewModel.vacancies.isEmpty || !viewModel.isSearchWasSuccess, remove: true)
            
            VStack(spacing: 0) {
                ProgressView()
                    .font(.largeTitle)
                    .padding()
            }
            .foregroundColor(.tx_sc)
            .padding()
            .background(Color.bg_sc)
            .cornerRadius(6)
            .isHidden(!(viewModel.isJobStatisticLoading && !viewModel.isVacancyListLoading), remove: true)
        }
    }
}

// MARK: - Private func

private extension JobStatisticView {
    
    func searachButtonTapped() {
        isPresented = true
    }
    
    func toggleSearchBar() {
        withAnimation(.easeIn(duration: 0.05)) {
            isSearchBarShown.toggle()
        }
    }
    
    func onSearch() {
        viewModel.searchJobStatistic()
        viewModel.searchVacancy()
    }
    
    func showMoreVacancies() {
        withAnimation {
            isVacancyListShownMore.toggle()
        }
    }
    
    func dismissView() {
        dismiss()
    }
}
