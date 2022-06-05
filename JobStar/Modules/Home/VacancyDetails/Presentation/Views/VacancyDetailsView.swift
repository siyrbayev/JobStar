//
//  VacancyDetailsView.swift
//  JobStar
//
//  Created by siyrbayev on 23.05.2022.
//

import SwiftUI

struct VacancyDetailsView_Previews: PreviewProvider {
    
    let vacancy = Vacancy.mock()
    
    static var previews: some View {
        VacancyDetailsView(vacancy: Vacancy.mock())
        //            .preferredColorScheme(.dark)
    }
}

struct VacancyDetailsView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    let vacancy: Vacancy
    
    // MARK: - Body
    
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                HStack {
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    KFImageView(url: vacancy.companyLogoUrl ?? "", placeholder: Image(systemName: "briefcase"))
                        .frame(width: 56, height: 56)
                        .background(Color.bg_clear)
                        .cornerRadius(.infinity)
                        .background(
                            Circle()
                                .stroke(Color.tx_sc, lineWidth: 2)
                                .blur(radius: 6)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(vacancy.area ?? "")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 12, weight: .medium))
                        
                        Text(vacancy.companyName ?? "")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 16, weight: .medium))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                
                Group {
                    HStack {
                        Text(vacancy.name ?? "")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(getSalary(from: vacancy.salaryFrom, to: vacancy.salaryTo, "The salary has not been determined"))
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.tx_sc)
                        
                        Text("KZT")
                            .foregroundColor(.tx_sc)
                            .font(.system(size: 12, weight: .semibold))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                }
                
                Group {
                    HStack {
                        Text("Match:")
                            .foregroundColor(.tx_pr)
                            .font(.system(size: 22, weight: .semibold))
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
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
                            .background(
                                Color.bg_sc
                                    .cornerRadius(12)
                            )
                            
                            Text("\(Int(vacancy.matchBySkillSet ?? 0.0))%")
                                .foregroundColor(.tx_pr)
                                .font(.system(size: 12, weight: .semibold))
                                .lineLimit(1)
                                .frame(width: 56)
                        }
                    }
                    .frame(height: 24)
                    .padding(.horizontal)
                }
                
                
                HStack {
                    Text("Required skills")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 22, weight: .semibold))
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top)
                
                SkillChainView(tags: vacancy.skillSet ?? [])
                    .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: dismissView) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.tx_pr)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Link(destination: URL(string: vacancy.linkToVacancy ?? "")!) {
                    Image(systemName: "network")
                        .foregroundColor(.accent_pr)
                        .font(.system(size: 16))
                }
            }
        }
    }
}

// MARK: - Private func

private extension VacancyDetailsView {
    
    func dismissView() {
        dismiss()
    }
    
    func getWidth(width: CGFloat) -> CGFloat {
        guard let percent = vacancy.matchBySkillSet, !percent.isZero else {
            return CGFloat(0)
        }
        
        return width / 100.0 * CGFloat(percent)
    }
    
    func getSalary(from: Double?, to: Double?, _ replacement: String = "") -> String {
        let from: String = (from ?? 0).isZero ? "" : String(format: "%.0f", from!)
        let to: String = (to ?? 0).isZero ? "" : String(format: "%.0f", to!)
        
        if !from.isEmpty && !to.isEmpty { return "\(from) - \(to)" }
        else if from.isEmpty && !to.isEmpty { return "up to \(to)" }
        else if to.isEmpty && !from.isEmpty { return "from \(from)" }
        else { return replacement }
    }
}
