//
//  MnemosyneApp.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

@main
struct MnemosyneApp: App {
    @StateObject private var jobStore = JobStore()

    var body: some Scene {
        WindowGroup {
            TabView {
                JobsView()
                SettingsView()
            }
            .environmentObject(jobStore)
            .onAppear(perform: jobStore.loadJobs)
        }
    }
}
