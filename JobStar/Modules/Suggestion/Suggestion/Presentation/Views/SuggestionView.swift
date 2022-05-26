//
//  SuggestionView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

struct SuggestionView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: SuggestionViewModel = SuggestionViewModel()
    
    // MARK: - State
    
    @State private var showDetail = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
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
    
    // MARK: - suitableJobList
    
    //    var suitableJobList: some View {
    //        Group {
    //            VStack(alignment: .leading) {
    //                if showDetail {
    //                    ForEach(Array(viewModel.suitableJobs.enumerated()), id: \.0) { index, suitableJob in
    //                        GraphCapsule(
    //                            suitableJob: suitableJob,
    //                            color: index == 0 ? .green : .lb_sc,
    //                            screenWidth: UIScreen.main.bounds.width - 78 - 32
    //                        )
    //                    }
    //                } else {
    //                    if let suitableJob = viewModel.suitableJobs.first {
    //                        GraphCapsule(
    //                            suitableJob: suitableJob,
    //                            color: .green,
    //                            screenWidth: UIScreen.main.bounds.width - 78 - 32
    //                        )
    //                    }
    //                }
    //            }
    //            .padding([.horizontal, .top])
    //            .transition(.move(edge: .top))
    //
    //            HStack {
    //                Spacer()
    //
    //                Button {
    //                    withAnimation {
    //                        showDetail.toggle()
    //                    }
    //                } label: {
    //                    Label("Graph", systemImage: "chevron.right.circle")
    //                        .labelStyle(.iconOnly)
    //                        .imageScale(.large)
    //                        .rotationEffect(.degrees(showDetail ? 270 : 90))
    //                        .padding([.horizontal, .horizontal])
    //                }
    //            }
    //        }
    //    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionView()
            .preferredColorScheme(.dark)
        
    }
}
