//
//  JobsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

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

    private var filteredJobs: [Job] {
        jobStore.jobs.filter({
            jobSearchText.isEmpty ? true :
                $0.title.lowercased().contains(jobSearchText.lowercased()) ||
                $0.company.lowercased().contains(jobSearchText.lowercased()) ||
                $0.status.rawValue.lowercased().contains(jobSearchText.lowercased())
        })
    }

    // MARK: - Methods

    private func addButtonTapped() {
        jobSheetVisible = true
    }

    // MARK: - Body

    var scrollableContent: some View {
        ScrollView {
            SearchBarView(searchText: $jobSearchText)
                .padding(.horizontal)
                .padding(.top, 8)
            Divider()
            LazyVStack {
                ForEach(filteredJobs) { job in
                    JobListItemView(job: job)
                    Divider()
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if jobStore.jobs.isEmpty {
                    Text("Add a job by pressing the + button")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    scrollableContent
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
                .previewDevice("iPhone SE (1st generation)")
            JobsView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityMedium)
                .previewDevice("iPhone SE (1st generation)")
        }
        .environmentObject(JobStore())
    }
}
#endif
