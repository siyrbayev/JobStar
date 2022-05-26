//
//  TagView.swift
//  JobStar
//
//  Created by siyrbayev on 22.05.2022.
//

import SwiftUI

struct TagView: View {
    
    var title: String = ""
    let skills: [Skill]
    
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            Text(title)
                .foregroundColor(.tx_sc)
                .font(.system(size: 12, weight: .semibold))
                .padding(.vertical, 10)
                .padding(.leading, 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width) {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    width -= d.width
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    return result
                })
                .isHidden(title.isEmpty, remove: true)
            ForEach(skills) { skill in
                item(for: skill)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if skill == self.skills.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if skill == self.skills.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: Skill) -> some View {
        Text(text.skill ?? "")
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .lineLimit(1)
            .background(Color.lb_pr.opacity(0.6))
            .cornerRadius(12)
            .overlay(
                Capsule()
                    .stroke(Color.lb_sc, lineWidth: 1)
                    .blur(radius: 2)
            )
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(skills: [])
    }
}

struct SkillsView: View {
    
    let skills: [Skill]
    
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(skills) { skill in
                item(for: skill)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if skill.skill ?? "" == self.skills.last!.skill ?? "" {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if skill.skill ?? "" == self.skills.last!.skill ?? "" {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for skill: Skill) -> some View {
        Text(skill.skill ?? "")
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .lineLimit(1)
            .background(Color.lb_pr.opacity(0.6))
            .cornerRadius(12)
            .overlay(
                Capsule()
                    .stroke(Color.lb_sc, lineWidth: 1)
                    .blur(radius: 2)
            )
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
