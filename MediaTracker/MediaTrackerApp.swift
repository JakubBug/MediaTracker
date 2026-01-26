//
//  MediaTrackerApp.swift
//  MediaTracker
//
//  Created by Mac-Jakub on 18/01/2026.
//

import SwiftUI
import SwiftData

@main
struct MeddiaTracker: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Media.self)
    }
}
