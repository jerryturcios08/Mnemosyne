//
//  SearchBarView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/7/20.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var editing = false

    private func cancelButtonTapped() {
        editing = false
        searchText = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    private func textFieldTapped() {
        editing = true
    }

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .onTapGesture(perform: textFieldTapped)
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
//            if editing {
//                Button("Cancel", action: cancelButtonTapped)
//                    .transition(.move(edge: .trailing))
//                    .animation(.default)
//            }
        }
    }
}

#if DEBUG
struct SearchBarViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant("Apple"))
                .previewLayout(.sizeThatFits)
                .padding()
            SearchBarView(searchText: .constant("Apple"))
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityMedium)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
#endif
