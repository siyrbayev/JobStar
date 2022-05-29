//
//  SuggestionView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI


struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView(tabSelection: .constant(TabBarItemTags.suggestions.rawValue))
            .preferredColorScheme(.dark)
        
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
                    ScrollView {
                        VStack {
                            NavigationLink(
                                destination: { JobStatisticView() },
                                label: { SuggestionNavigationRowItemView(title: "Salary statistic") }
                            )
                            
                            NavigationLink(
                                destination: { CompanySalaryStatisticView() },
                                label: { SuggestionNavigationRowItemView(title: "Companies Salary statistic") }
                            )
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 8)
                        
                        Spacer()
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
}

