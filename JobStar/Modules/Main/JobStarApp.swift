//
//  JobStarApp.swift
//  JobStar
//
//  Created by siyrbayev on 17.03.2022.
//

import SwiftUI
import PartialSheet

@main
struct JobStarApp: App {
    
    // MARK: - Environment
    
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .attachPartialSheetToRoot()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                print("App is in background")
            case .inactive:
                print("App is inactive")
            case .active:
                print("App is active")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
