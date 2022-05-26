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
            VStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame( width: 2, height: 2)
                        .background(Color.bg_clear)
                    
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
                            .background(
                                LinearGradient(colors: [.bg_sc, .bg_clear], startPoint: .top, endPoint: .bottom)
                            )
                            
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
                .isHidden(!isSearchBarShown, remove: true)
                
                VStack {
                    barChart
                        .disabled(viewModel.isJobStatisticLoading)
                    
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
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                JobStatisticSetCityView(viewModel: viewModel, isPresented: $isPresented)
                    .navigationBarHidden(false)
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
                Button(action: isSearchBarShown ? toggleSearchBar : dismissView) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.accent_pr)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    HStack {
                        CustomUITextField(placeHolder: "Search", text: $viewModel.wordToFind, isFirstResponder: true, shouldReturn: {
                            onSearch()
                            toggleSearchBar()
                        })
                        .frame(width: UIScreen.main.bounds.width * 2/3)
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 16, weight: .medium))
                    }
                    
                    Spacer()
                    
                    Button(action: toggleSearchBar) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.accent_pr)
                            .frame(height: 40)
                    }
                }
                .isHidden(!isSearchBarShown, remove: true)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleSearchBar) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.accent_pr)
                }
                .isHidden(isSearchBarShown, remove: true)
            }
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
                            VStack {
                                ForEach (viewModel.vacancies) { vacancy in
                                    NavigationLink {
                                        VacancyDetailsView(vacancy: vacancy)
                                    } label: {
                                        VacancyRowItemView(isVIP: false, vacancy: vacancy)
                                            .padding(.horizontal)
                                    }
                                }
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
    
    var searchButton: some View {
        Group {
            Button(action: searachButtonTapped) {
                Label("Search", systemImage: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.horizontal, 24)
                    .padding(.vertical)
                    .background(
                        LinearGradient(
                            colors: [.lb_pr, .lb_sc, .lb_pr, .lb_pr],
                            startPoint: .topLeading, endPoint: .topTrailing
                        )
                        .padding(-12)
                        .blur(radius: 12)
                    )
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Text("Search for job salary statistic")
                .foregroundColor(.tx_sc)
                .font(.system(size: 12, weight: .medium))
                .padding(8)
        }
        .isHidden(viewModel.isSearchWasSuccess, remove: true)
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
        viewModel.search()
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
