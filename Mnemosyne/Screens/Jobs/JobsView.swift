//
//  JobsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI
import CoreData

// TODO: Implemenet filter functionality

fileprivate enum Filter: String {
    case title = "Title name"
    case company = "Company name"
    case dateApplied = "Date applied"
    case favorite = "Favorite"
}

struct JobsView: View {
    // MARK: - Properties

    @EnvironmentObject var jobStore: JobStore
    @State private var jobSearchText = ""
    @State private var selectedFilterOption = 3

    // Alert visibility boolean values
    @State private var jobSheetVisible = false

    private var filterOptions: [Filter] = [.title, .company, .dateApplied, .favorite]

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
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Filter options", selection: $selectedFilterOption) {
                            Text(filterOptions[0].rawValue).tag(0)
                            Text(filterOptions[1].rawValue).tag(1)
                            Text(filterOptions[2].rawValue).tag(2)
                            Text(filterOptions[3].rawValue).tag(3)
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addButtonTapped) {
                        Image(systemName: "plus")
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
        Group {
            JobsView()
            JobsView()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
