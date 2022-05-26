//
//  JobStatisticBarChartView.swift
//  JobStar
//
//  Created by siyrbayev on 11.05.2022.
//

import SwiftUI

struct JobStatisticBarChartView: View {
    
    let jobAverageSalary: JobAverageSalary
    var width: CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .trailing) {
                    ForEach(jobAverageSalary.data ?? [], id: \.self) { item in
                        HStack(spacing: 0) {
                                Text("\(item.salary ?? 0)")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.tx_sc)
                            
                                Text("KZT")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.tx_sc)
                        }
                        .padding(8)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(jobAverageSalary.data ?? [], id: \.self) { item in
                        HStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: (width/2.5 * CGFloat(item.salary ?? 0)/CGFloat(jobAverageSalary.getMaxSalary())) , height: 38)
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
                            
                            
                            Text(item.year ?? "")
                                .font(.system(size: 12, weight: .medium))
                                .frame(width: 32)
                                .foregroundColor(.tx_sc)
                        }
                    }
                }
                .padding(.leading, 8)
                .background(
                    HStack {
                        ForEach(jobAverageSalary.data ?? [], id: \.self) { item in
                            Divider()
                            Spacer()
                        }
                        
                        Divider()
                    }
                )
            }
            .padding()
        }
    }
}

struct JobStatisticMiniBarChartView: View {
    
    var jobAverageSalary: JobAverageSalary
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(jobAverageSalary.data ?? [], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: (width * (CGFloat(item.salary ?? 0)/CGFloat(jobAverageSalary.getMaxSalary()))) , height: width/6)
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
                }
            }
        }
        .background(
            HStack {
                ForEach(jobAverageSalary.data ?? [], id: \.self) { item in
                    Divider()
                    Spacer()
                }
                
                Divider()
            }
        )
        .frame(width: width, height: width)
    }
}

struct JobStatisticMiniBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        JobStatisticMiniBarChartView( jobAverageSalary: JobAverageSalary.mock(), width: UIScreen.main.bounds.width)
            .preferredColorScheme(.dark)
            
    }
}

struct JobStatisticBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        JobStatisticBarChartView( jobAverageSalary: JobAverageSalary.mock(), width: UIScreen.main.bounds.width)
            .preferredColorScheme(.dark)
            
    }
}
