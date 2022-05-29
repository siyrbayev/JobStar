//
//  VacancyRowItemView.swift
//  JobStar
//
//  Created by siyrbayev on 21.05.2022.
//

import SwiftUI

struct VacancyRowItem_Previews: PreviewProvider {
    static var previews: some View {
        VacancyRowItemView( isVIP: true, vacancy: Vacancy.mock())
//            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
    }
}

struct VacancyRowItemView: View {
    
    let isVIP: Bool
    let vacancy: Vacancy
    
    private var linearGradient: LinearGradient {
        get {
            guard let matchPercent = vacancy.matchBySkillSet else {
                return LinearGradient(colors: [.error.opacity(0.5), .gray], startPoint: .leading, endPoint: .trailing)
            }
            
            if matchPercent >= 75 {
                return LinearGradient(colors: [.lb_sc.opacity(0.5), .lb_sc], startPoint: .leading, endPoint: .trailing)
            } else if matchPercent < 75 && matchPercent >= 50 {
                return LinearGradient(colors: [.warning.opacity(0.5), .warning], startPoint: .leading, endPoint: .trailing)
            } else if matchPercent < 50 && matchPercent >= 25 {
                return LinearGradient(colors: [.error.opacity(0.5), .warning], startPoint: .leading, endPoint: .trailing)
            } else {
                return LinearGradient(colors: [.error.opacity(0.5), .error], startPoint: .leading, endPoint: .trailing)
            }
        }
    }
    
    private func getSalary(from: Double?, to: Double?, _ replacement: String = "") -> String {
        let from: String = (from ?? 0).isZero ? "" : String(format: "%.0f", from!)
        let to: String = (to ?? 0).isZero ? "" : String(format: "%.0f", to!)
        
        if !from.isEmpty && !to.isEmpty { return "\(from) - \(to) KZT" }
        else if from.isEmpty && !to.isEmpty { return "up to \(to) KZT" }
        else if to.isEmpty && !from.isEmpty { return "from \(from) KZT" }
        else { return replacement }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.warning)
                    .frame(width: 28, height: 28)
                    .cornerRadius(.infinity)
                    .padding(.trailing, 6)
                    .isHidden(!isVIP, remove: true)
                
                Text(vacancy.name ?? "")
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                
                Spacer()
                
                KFImageView(url: vacancy.companyLogoUrl ?? "", placeholder: Image(systemName: "briefcase"))
                    .cancelOnDisappear(true)
                    .frame(width: 28, height: 28)
                    .cornerRadius(.infinity)
                    .padding(.horizontal, 8)
                
            }
            .padding([.vertical], 8)
            
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(getSalary(from: vacancy.salaryFrom, to: vacancy.salaryTo, "The salary has not been determined"))
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                            .frame(height: 24)
                        
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text(vacancy.companyName ?? "")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    
                    HStack {
                        
                        Text(vacancy.area ?? "")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Text("Match:")
                .foregroundColor(.tx_sc)
                .font(.system(size: 12, weight: .bold))
                .padding([.top], 8)
            
            HStack {
                HStack(spacing: 0) {
                    GeometryReader { geomerty in
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.clear)
                            .frame(width: getWidth(width: geomerty.size.width), height: 24)
                            .background(
                                linearGradient
                            )
                            .cornerRadius(12)
                    }
                    
                    Text("\(Int(vacancy.matchBySkillSet ?? 0.0))%")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1)
                        .frame(width: 56)
                }
            }
            .frame(height: 24)
            .padding(.bottom, 8)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.bg_sc)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.warning, lineWidth: 2)
                .blur(radius: 2)
                .isHidden(!isVIP, remove: true)
        )
        .cornerRadius(12)
    }
    
    func getWidth(width: CGFloat) -> CGFloat {
        guard let percent = vacancy.matchBySkillSet, !percent.isZero else {
            return CGFloat(0)
        }
        
        return width / 100.0 * CGFloat(percent)
    }
}
