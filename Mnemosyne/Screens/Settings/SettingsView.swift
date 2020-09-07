//
//  SettingsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Settings")
        }
        .tabItem {
            Image(systemName: "gear")
            Text("Settings")
        }
    }
}

#if DEBUG
struct SettingsViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
