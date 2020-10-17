//
//  ProfileView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
        }
        .tabItem {
            Image(systemName: "person")
            Text("Profile")
        }
    }
}

#if DEBUG
struct ProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice("iPhone SE (1st generation)")
    }
}
#endif
