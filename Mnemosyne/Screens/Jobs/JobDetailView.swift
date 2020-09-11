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

    @State private var notesText = ""
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

    private var dateString: String {
        guard let dateApplied = job?.dateApplied else { return "N/a" }
        return DateFormatter.localizedString(from: dateApplied, dateStyle: .long, timeStyle: .none)
    }

    // MARK: - Methods

    private func configureView() {
        guard let notes = job?.notes else { return }
        notesText = notes
    }

    private func editButtonTapped() {
        editScreenVisible = true
    }

    private func heartButtonTapped() {
        guard let job = job else { return }
        jobStore.toggleFavorite(for: job.id)
    }

    // MARK: - Body

    func getRowContent(header: String, value: String, color: Color) -> some View {
        HStack {
            Text(header)
            Spacer()
            Text(value)
                .foregroundColor(color)
        }
    }

    var body: some View {
        if let job = job {
            Form {
                Section {
                    getRowContent(header: "Title", value: job.title, color: .gray)
                    getRowContent(header: "Company", value: job.company, color: .gray)
                    if let contact = job.contact {
                        getRowContent(header: "Contact", value: contact, color: .gray)
                    }
                    getRowContent(header: "Status", value: job.status.rawValue, color: statusColor)
                    getRowContent(header: "Date applied", value: dateString, color: .gray)
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: $notesText)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(job.title)
            .fullScreenCover(isPresented: $editScreenVisible) { EditJobView(job: job) }
            .onAppear(perform: configureView)
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
