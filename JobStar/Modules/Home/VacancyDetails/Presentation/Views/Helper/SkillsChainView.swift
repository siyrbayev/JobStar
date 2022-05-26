//
//  SkillsChainView.swift
//  JobStar
//
//  Created by siyrbayev on 23.05.2022.
//

import SwiftUI

struct SkillChainView: View {
    let tags: [String]
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
            ForEach(tags, id: \.self) { tag in
                item(for: tag)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .lineLimit(1)
            .background(Color.lb_sc.opacity(0.7))
            .cornerRadius(12)
            .overlay(
                Capsule()
                    .stroke(Color.lb_sc, lineWidth: 2)
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

struct SkillChainView_Previews: PreviewProvider {
    static var previews: some View {
        SkillChainView(tags: ["iOS Developper", "SwiftUI", "UIKit", "Auto Layaout", "Core Data"])
    }
}
