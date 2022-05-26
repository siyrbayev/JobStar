//
//  SuggestionNavigationRawItem.swift
//  JobStar
//
//  Created by siyrbayev on 12.05.2022.
//

import SwiftUI

struct SuggestionNavigationRowItemView: View {
    
    // MARK: - Public property
    
    let title: String
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal)
                .padding(.vertical, 8)
                .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(.horizontal)
        }
        .foregroundColor(.tx_pr)
        .padding(.vertical, 8)
        .background(
            Color.secondary.opacity(0.2)
        )
        .cornerRadius(12)
    }
}

// MARK: - Preview

struct SuggestionNavigationRawItem_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionNavigationRowItemView(title: "Title")
    }
}
