//
//  JobsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI
import CoreData

struct JobsView: View {
    // MARK: - Properties

    @EnvironmentObject var jobStore: JobStore
    @State private var jobSearchText = ""

    // Alert visibility boolean values
    @State private var jobSheetVisible = false

    // MARK: - Methods

    private func addButtonTapped() {
        jobSheetVisible = true
    }

    // MARK: - Body

    var scrollableContent: some View {
        ScrollView {
            Divider()
            LazyVStack {
                ForEach(jobStore.jobs) { job in
                    JobListItemView(job: job)
                    Divider()
                }
            }
        }
        .padding(.top, 62)
    }

    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    if jobStore.jobs.isEmpty {
                        Text("No jobs have been found!")
                            .font(.headline)
                            .foregroundColor(.gray)
                    } else {
                        scrollableContent
                    }
                    VStack {
                        SearchBarView(searchText: $jobSearchText)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Jobs")
            .fullScreenCover(isPresented: $jobSheetVisible) { JobSheetView() }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addButtonTapped) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
        .tabItem {
            Image(systemName: "briefcase")
            Text("Jobs")
        }
    }
}

// MARK: - Previews

#if DEBUG
struct JobsViewPreviews: PreviewProvider {
    static var previews: some View {
        JobsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        JobsView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
