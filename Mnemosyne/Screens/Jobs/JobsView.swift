//
//  JobsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

// TODO: Implemenet sorting functionality

fileprivate enum Sort: String {
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
    @State private var addJobScreenVisible = false

    private var sortingOptions: [Sort] = [.title, .company, .dateApplied, .favorite]

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
        addJobScreenVisible = true
    }

    // MARK: - Body

    private var navigationBarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Menu {
                    Picker("Filter options", selection: $selectedFilterOption) {
                        Text(sortingOptions[0].rawValue).tag(0)
                        Text(sortingOptions[1].rawValue).tag(1)
                        Text(sortingOptions[2].rawValue).tag(2)
                        Text(sortingOptions[3].rawValue).tag(3)
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

    private var scrollableContent: some View {
        ScrollView {
            SearchBarView(searchText: $jobSearchText)
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 4)
            Divider()
            LazyVStack {
                ForEach(filteredJobs) { job in
                    NavigationLink(destination: JobDetailView(job: job)) {
                        JobListItemView(job: job)
                    }
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
            .fullScreenCover(isPresented: $addJobScreenVisible) { AddJobView() }
            .toolbar { navigationBarItems }
            JobDetailView(job: nil)
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
