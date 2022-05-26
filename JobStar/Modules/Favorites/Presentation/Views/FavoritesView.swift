//
//  FavoritesView.swift
//  JobStar
//
//  Created by siyrbayev on 19.03.2022.
//

import SwiftUI

struct FavoritesView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    // MARK: - Body
    
    var body: some View {
        Text("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
