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

//struct JobStatisticMiniBarChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobStatisticMiniBarChartView( jobAverageSalary: JobAverageSalary.mock(), width: UIScreen.main.bounds.width)
//            .preferredColorScheme(.dark)
//
//    }
//}
//
//struct JobStatisticBarChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobStatisticBarChartView( jobAverageSalary: JobAverageSalary.mock(), width: UIScreen.main.bounds.width)
//            .preferredColorScheme(.dark)
//
//    }
//}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        //        NavigationView {
        //            NavigationLink {
        //                BarChartView(width: UIScreen.main.bounds.width)
        //
        //            } label: {
        //                Text("lol")
        //            }
        //        }
        //        BarChartView(width: UIScreen.main.bounds.width, height: 48)
        ListChartView(width: UIScreen.main.bounds.width, height: 48)
    }
}

struct BarChartView: View {
    
    var width: CGFloat
    var height: CGFloat
    
    @State private var item1: Double = 0.0
    @State private var item2: Double = 0.0
    @State private var item3: Double = 0.0
    @State private var item4: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(
                        width: (width * CGFloat(item1)) / 100.0,
                        height: height)
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
                
                Spacer()
            }
            RoundedRectangle(cornerRadius: 12)
                .frame(
                    width: (width * CGFloat(item2)) / 100.0,
                    height: height)
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
            RoundedRectangle(cornerRadius: 12)
                .frame(
                    width: (width * CGFloat(item3)) / 100.0,
                    height: height)
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
            RoundedRectangle(cornerRadius: 12)
                .frame(
                    width: (width * CGFloat(item4)) / 100.0,
                    height: height)
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    
                    item1 = 25.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item2 = 50.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item3 = 75.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item4 = 100.0
                }
                
            }
        }
        .onDisappear {
            item1 = 0.0
            item2 = 0.0
            item3 = 0.0
            item4 = 0.0
        }
    }
}

struct ListChartView: View {
    
    var width: CGFloat
    var height: CGFloat
    
    @State private var item1: Double = 0.0
    @State private var item2: Double = 0.0
    @State private var item3: Double = 0.0
    @State private var item4: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Capsule()
                    .frame(
                        width: (width * CGFloat(item1)) / 100.0,
                        height: height)
                    .foregroundColor(.clear)
                    .background(
                        LinearGradient(
                            colors: [.warning.opacity(0.7), .success],
                            startPoint: .topLeading, endPoint: .trailing
                        )
                        .padding(-12)
                        .blur(radius: 4)
                    )
                    .cornerRadius(.infinity)
                
                Spacer()
            }
            Capsule()
                .frame(
                    width: (width * CGFloat(item2)) / 100.0,
                    height: height)
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        colors: [.warning.opacity(0.7), .success],
                        startPoint: .topLeading, endPoint: .trailing
                    )
                    .padding(-12)
                    .blur(radius: 4)
                )
                .cornerRadius(.infinity)
            
            Capsule()
                .frame(
                    width: (width * CGFloat(item3)) / 100.0,
                    height: height)
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        colors: [.warning.opacity(0.7), .success],
                        startPoint: .topLeading, endPoint: .trailing
                    )
                    .padding(-12)
                    .blur(radius: 4)
                )
                .cornerRadius(.infinity)
            
            Capsule()
                .frame(
                    width: (width * CGFloat(item4)) / 100.0,
                    height: height)
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        colors: [.warning.opacity(0.7), .success],
                        startPoint: .topLeading, endPoint: .trailing
                    )
                    .padding(-12)
                    .blur(radius: 4)
                )
                .cornerRadius(.infinity)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    
                    item1 = 45.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item2 = 100.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item3 = 75.0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 1)) {
                    item4 = 35.0
                }
            }
        }
        
        .onDisappear {
            item1 = 0.0
            item2 = 0.0
            item3 = 0.0
            item4 = 0.0
        }
    }
}
