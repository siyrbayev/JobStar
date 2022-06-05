//
//  SuggestionView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

// MARK: - Previews

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView(tabSelection: .constant(TabBarItemTags.suggestions.rawValue))
//            .preferredColorScheme(.dark)
    }
}

struct SuggestionView: View {
    
    // MARK: - Binding
    
    @Binding var tabSelection: Int
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: SuggestionViewModel = SuggestionViewModel()
    
    // MARK: - State
    
    @State private var showDetail = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                if (AppData.applicant.resumes ?? []).isEmpty {
                    empty
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            NavigationLink(
                                destination: { JobStatisticView() },
                                label: {
                                    barChart
                                }
                            )
                            
                            NavigationLink(
                                destination: { CompanySalaryStatisticView() },
                                label: {
                                    listChart
                                }
                            )
                        }
                        .padding(.vertical)
                    }
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Suggestion")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 32, weight: .bold))
                }
            }
        }
    }
    
    var listChart: some View {
        VStack(alignment: .leading) {
            ListChartView(width: UIScreen.main.bounds.width/1.4, height: 36)
            
            Text("Companies avarage salary")
                .foregroundColor(.tx_pr)
                .font(.system(size: 22, weight: .bold))
                .padding(.vertical, 8)
            
            Text("Find out the company's average salary statistic of your desired job position")
                .foregroundColor(.tx_sc)
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(32)
        .background(Color.bg_sc)
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    var barChart: some View {
        VStack(alignment: .leading) {
            BarChartView(width: UIScreen.main.bounds.width/1.4, height: 48)
            
            Text("Salary statistic")
                .foregroundColor(.tx_pr)
                .font(.system(size: 22, weight: .bold))
                .padding(.vertical, 8)
            
            Text("Find out the average salary of your desired job position")
                .foregroundColor(.tx_sc)
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .medium))
        }
        .padding(32)
        .background(Color.bg_sc)
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    var empty: some View {
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
    }
}
