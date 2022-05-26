/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single line in the graph.
*/

import SwiftUI

struct GraphCapsule: View, Equatable {
    
    var suitableJob: SuitableJob
    var color: Color
    var screenWidth: CGFloat

    private var width: CGFloat {
        CGFloat(suitableJob.suitabilityScore ?? 0)/100 * screenWidth
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(suitableJob.name ?? "")
                .padding(.leading)
                .font(.system(size: 14, weight: .bold))
            
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                    .frame(width: width, height: 36)
                
                Spacer()
                
                Text("\(suitableJob.suitabilityScore ?? 0)%")
                    .padding(.trailing)
                    .font(.system(size: 14, weight: .bold))
            }
        }
    }
}

struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            GraphCapsule(
                suitableJob: SuitableJob(id: 0, name: "LOl", suitabilityScore: 12),
                color: .lb_sc,
                screenWidth: UIScreen.main.bounds.width
                - 78
            )
        }
    }
}
