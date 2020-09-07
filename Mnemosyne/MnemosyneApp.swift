//
//  MnemosyneApp.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

@main
struct MnemosyneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                JobsView()
                SettingsView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
