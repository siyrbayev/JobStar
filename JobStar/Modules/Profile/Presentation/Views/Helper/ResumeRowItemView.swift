//
//  ResumeRowItemView.swift
//  JobStar
//
//  Created by siyrbayev on 22.05.2022.
//

import SwiftUI

struct ResumeRowItemView: View {
    
    let resume: Resume
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(resume.title ?? "")
                    .foregroundColor(.tx_pr)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.tx_sc)
                        .frame(width: 12, height: 12)
                        .padding(.trailing, 6)
                    
                    Text("\(resume.firstName ?? "") \(resume.secondName ?? "")")
                        .foregroundColor(.tx_sc)
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .foregroundColor(.tx_sc)
                        .frame(width: 14, height: 10)
                        .padding(.trailing, 4)
                        .padding(.top, 2)
                    
                    Text(resume.email ?? "")
                        .foregroundColor(.tx_sc)
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
            }
            
            
            Text(resume.description ?? "")
                .multilineTextAlignment(.leading)
                .foregroundColor(.tx_pr)
                .font(.system(size: 14, weight: .regular))
                .lineLimit(3)
                .padding(.vertical)
            
            TagView(title: "Skills", skills: resume.skills ?? [])
                .padding(-4)
            
            HStack {
                Spacer()
                
                Text("Work experience: \(resume.totalWorkExperience ?? 0) years")
                    .foregroundColor(.tx_sc)
                    .font(.system(size: 12, weight: .semibold))
            }
        }
        .padding()
        .background(
            Color.bg_sc
        )
        .cornerRadius(12)
    }
}

struct ResumeRowItemView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeRowItemView(resume: Resume.mock()!)
//            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
    }
}
