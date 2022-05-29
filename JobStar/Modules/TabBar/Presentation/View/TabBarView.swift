//
//  TabView.swift
//  JobStar
//
//  Created by siyrbayev on 17.03.2022.
//

import SwiftUI

extension EnvironmentValues {
    
}

struct TabBarView: View {
    
    // MARK: - StateObject
    
    @StateObject private var viewModel: TabBarViewModel = TabBarViewModel()
    
    // MARK: - State
    
    @State private var selection: Int = 0
    
    // MARK: - Init
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.bg_clear)
    }
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selection) {
            home
            suggestion
//            favorites
            profie
        }
        .accentColor(.accent_pr)
        .onAppear {
            viewModel.onApper()
        }
    }
    
    // MARK: - Home
    
    private var home: some View {
        
        HomeView(tabSelection: $selection)
            .tabItem {
                Label("Home", systemImage: isHome ? "house.fill" : "house")
                    .environment(\.symbolVariants, .none)
            }
            .tag(TabBarItemTags.home.rawValue)
    }
    
    // MARK: - Suggestion
    
    private var suggestion: some View {
        
        SuggestionView(tabSelection: $selection)
            .tabItem {
                Label("Suggestion", systemImage: isSuggestion ? "chart.line.uptrend.xyaxis.circle.fill" : "chart.line.uptrend.xyaxis.circle")
                    .environment(\.symbolVariants, .none)
            }
            .tag(TabBarItemTags.suggestions.rawValue)
    }
    
    // MARK: - Favorites
    
    private var favorites: some View {
        
        FavoritesView()
            .tabItem {
                Label("Favorites", systemImage: isFavorite ? "heart.fill" : "heart")
                    .environment(\.symbolVariants, .none)
            }
            .tag(TabBarItemTags.favorites.rawValue)
    }
    
    // MARK: - Profile
    
    private var profie: some View {
        
        ProfileView()
            .tabItem {
                Label("Profile", systemImage: isProfile ? "person.circle.fill" : "person.crop.circle")
                    .environment(\.symbolVariants, .none)
            }
            .tag(TabBarItemTags.profile.rawValue)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

// MARK: - Private func

private extension TabBarView {
    
    var isHome: Bool {
        selection == TabBarItemTags.home.rawValue
    }
    
    var isSuggestion: Bool {
        selection == TabBarItemTags.suggestions.rawValue
    }
    
    var isFavorite: Bool {
        selection == TabBarItemTags.favorites.rawValue
    }
    
    var isProfile: Bool {
        selection == TabBarItemTags.profile.rawValue
    }
}
