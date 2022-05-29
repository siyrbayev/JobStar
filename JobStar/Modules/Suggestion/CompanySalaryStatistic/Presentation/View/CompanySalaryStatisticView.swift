//
//  CompanySalaryStatisticView.swift
//  JobStar
//
//  Created by siyrbayev on 12.05.2022.
//

import SwiftUI

// MARK: - Preview

struct CompanySalaryStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySalaryStatisticView()
    }
}

struct CompanySalaryStatisticView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: CompanySalaryStatisticViewModel = CompanySalaryStatisticViewModel()
    
    // MARK: - State
    
    @State private var isDismiss: Bool = true
    
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
                    listChart
                        .disabled(viewModel.isJobStatisticLoading)
                }
                .isHidden(isSearchBarShown, remove: true)
                
            }
            .background(Color.bg_clear)
            .isBlur(viewModel.isJobStatisticLoading, radius: 6)
            
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
            .isHidden(!viewModel.isJobStatisticLoading, remove: true)
        }
        .onAppear {
            
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                JobStatisticSetCityView(cityName: $viewModel.cityNameToSearch, cities: $viewModel.cities, onSetCity: { city in
                    viewModel.setCity(city)
                }, isPresented: $isPresented)
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
                        
                        CustomUITextField(placeHolder: "Search", text: $viewModel.wordToFind, isFirstResponder: true, shouldReturn: {
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
    
    var listChart: some View {
        VStack(spacing: 0) {
            Text(viewModel.avarageCompanySalary.name ?? "")
                .multilineTextAlignment(.leading)
                .font(.system(size: 18, weight: .regular))
                .padding()
            
            ZStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.avarageCompanySalary.data ?? [], id: \.self) { item in
                        VStack(spacing: 6) {
                            HStack {
                                Text(item.companyName ?? "")
                                    .foregroundColor(item.salary ?? 0 > 0 ? .tx_pr : .tx_sc )
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Spacer()
                                
                                Text("\(item.salary ?? 0) KZT")
                                    .foregroundColor(item.salary ?? 0 > 0 ? .tx_pr : .tx_sc )
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            GeometryReader { geometry in
                                if item.salary ?? 0 > 0 {
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(
                                            width: (geometry.size.width * CGFloat(item.salary ?? 0) / CGFloat(viewModel.avarageCompanySalary.getMaxSalary())),
                                            height: 20
                                        )
                                        .foregroundColor(.clear)
                                        .background(
                                            LinearGradient(
                                                colors: [.lb_sc.opacity(0.7), .lb_pr],
                                                startPoint: .topLeading, endPoint: .trailing
                                            )
                                            .padding(-12)
                                            .blur(radius: 4)
                                        )
                                        .cornerRadius(12)
                                } else {
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(
                                            width: (geometry.size.width),
                                            height: 20
                                        )
                                        .foregroundColor(.clear)
                                        .background(
                                            Color.bg_clear.opacity(0.7)
                                        )
                                        .cornerRadius(12)
                                }
                                
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                        .background(
                            Color.bg_sc
                        )
                        .cornerRadius(12)
                    }
                    
                    Divider()
                        .padding(.top)
                    
                    Text("End of list")
                        .padding(.bottom, -78)
                        .foregroundColor(.tx_sc)
                        .font(.system(size: 14, weight: .regular))
                }
                .padding(.horizontal)
                .padding(.top, 28)
                .padding(.bottom, -18)
            }
                VStack() {
                    RoundedRectangle(cornerRadius: 0)
                        .frame(height: 20)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(
                                colors: [.bg_clear, .bg_clear, .bg_clear.opacity(0.1)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Private func

private extension CompanySalaryStatisticView {
    
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
