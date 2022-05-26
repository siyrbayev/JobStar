//
//  CompanySalaryStatisticView.swift
//  JobStar
//
//  Created by siyrbayev on 12.05.2022.
//

import SwiftUI

struct CompanySalaryStatisticView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: CompanySalaryStatisticViewModel = CompanySalaryStatisticViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: searachButtonTapped) {
                Label("Search", systemImage: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.horizontal, 48)
                    .padding(.vertical)
                    .background(
                        LinearGradient(
                            colors: [.lb_pr, .lb_sc, .lb_pr],
                            startPoint: .topLeading, endPoint: .bottom
                        )
                        .padding(0)
                        .blur(radius: 12)
                        .background(
                            Color.bg_off
                        )
                    )
                    .cornerRadius(12)
            }
            .padding([.leading, .trailing, .top])
            
            Text("Search for job salary statistic")
                .foregroundColor(.tx_sc)
                .font(.system(size: 12, weight: .medium))
                .padding(8)
        }
    }
}

// MARK: - Private func

private extension CompanySalaryStatisticView {
    
    func searachButtonTapped() { }
}

// MARK: - Preview

struct CompanySalaryStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        CompanySalaryStatisticView()
    }
}
