//
//  JobDetailView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/10/20.
//

import SwiftUI

struct JobDetailView: View {
    // MARK: - Properties

    @EnvironmentObject var jobStore: JobStore
    @State private var editScreenVisible = false

    var job: Job?

    private var statusColor: Color {
        switch job?.status {
        case .applied:
            return Color.green
        case .offer:
            return Color.blue
        case .onSite:
            return Color.purple
        case .phoneScreen:
            return Color.orange
        case .rejected:
            return Color.red
        case .none:
            return Color.gray
        }
    }

    // MARK: - Methods

    private func editButtonTapped() {
        editScreenVisible = true
    }

    private func heartButtonTapped() {
        guard let job = job else { return }
        jobStore.toggleFavorite(for: job.id)
    }

    // MARK: - Body

    var body: some View {
        if let job = job {
            Form {
                Section {
                    HStack {
                        Text("Title")
                        Spacer()
                        Text(job.title)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Company")
                        Spacer()
                        Text(job.company)
                            .foregroundColor(.gray)
                    }
                    if let contact = job.contact {
                        HStack {
                            Text("Contact")
                            Spacer()
                            Text(contact)
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("Status")
                        Spacer()
                        Text(job.status.rawValue)
                            .foregroundColor(statusColor)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(job.title)
            .fullScreenCover(isPresented: $editScreenVisible) { EditJobView(job: job) }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: editButtonTapped) {
                        Image(systemName: "square.and.pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: heartButtonTapped) {
                        Image(systemName: job.favorite ? "heart.fill" : "heart")
                    }
                }
            }
        } else {
            VStack {
                Text("No job is selected.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Detail")
        }
    }
}

// MARK: - Previews

#if DEBUG
struct JobDetailViewPreviews: PreviewProvider {
    static var previews: some View {
        JobDetailView(
            job: Job(
                title: "iOS Engineer",
                company: "Hinge",
                dateApplied: Date(),
                favorite: true,
                status: .applied
            )
        )
    }
}
#endif
