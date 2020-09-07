//
//  JobsView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI
import CoreData

enum Status: String {
    case applied = "Applied"
    case phoneScreen = "Phone Screen"
    case onSite = "On Site"
    case offer = "Offer"
    case rejected = "Rejected"
}

struct Job: Identifiable {
    var id = UUID()
    var title: String
    var company: String
    var dateApplied: Date
    var favorite = false
    var status: Status
}

struct JobsView: View {
    // MARK: - Properties

    @State private var jobs: [Job] = [
        .init(title: "Software Engineer", company: "Apple", dateApplied: Date(), status: .applied),
        .init(title: "Software Engineer", company: "Google", dateApplied: Date(), status: .phoneScreen),
        .init(title: "Software Developer", company: "The global place of the universe", dateApplied: Date(), status: .onSite),
        .init(title: "iOS Engineer", company: "Netflix", dateApplied: Date(), favorite: true, status: .rejected),
        .init(title: "Product Manager", company: "The Boring Company", dateApplied: Date(), status: .offer),
        .init(title: "Software Engineer", company: "Apple", dateApplied: Date(), status: .applied),
        .init(title: "Software Engineer", company: "Google", dateApplied: Date(), status: .phoneScreen),
        .init(title: "Software Developer", company: "The global place of the universe", dateApplied: Date(), status: .onSite),
        .init(title: "iOS Engineer", company: "Netflix", dateApplied: Date(), favorite: true, status: .rejected),
        .init(title: "Product Manager", company: "The Boring Company", dateApplied: Date(), status: .offer)
    ]
    @State private var jobSearchText = ""

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
                ForEach(jobs) { job in
                    NavigationLink(destination: JobDetailView(job: job)) {
                        JobListItemView(job: job)
                    }
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
                    if jobs.isEmpty {
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
