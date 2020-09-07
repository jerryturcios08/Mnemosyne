//
//  JobsListItemView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/6/20.
//

import SwiftUI

struct JobListItemView: View {
    // MARK: - Properties

    @State private var trashAlertVisible = false

    var job: Job

    private var statusColor: Color {
        switch job.status {
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
        }
    }

    // MARK: - Methods

    private func heartButtonTapped() {
        // TODO: Change the data in the database
    }

    private func editButtonTapped() {
    }

    private func trashButtonTapped() {
        trashAlertVisible = true
    }

    // MARK: - Body

    @ViewBuilder
    var actionGroup: some View {
        Button(action: heartButtonTapped) {
            Image(systemName: job.favorite ? "heart.fill" : "heart")
                .font(.title3)
        }
        Button(action: editButtonTapped) {
            Image(systemName: "square.and.pencil")
                .font(.title3)
        }
        .padding(.horizontal, 6)
        Button(action: trashButtonTapped) {
            Image(systemName: "trash")
                .font(.title3)
        }
    }

    var trashAlert: Alert {
        Alert(
            title: Text("Warning"),
            message: Text("Are you sure you want to delete the \(job.title) job at \(job.company) from your list?"),
            primaryButton: .destructive(Text("Delete"), action: {
                // TODO: Add call to delete item from database
            }),
            secondaryButton: .cancel(Text("Cancel"))
        )
    }

    var body: some View {
        VStack {
            HStack {
                // TODO: Look into using Crunchbase API to provide images
                VStack(alignment: .leading) {
                    Text("\(job.title)")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("\(job.company)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(job.status.rawValue)")
                        .font(.subheadline)
                        .foregroundColor(statusColor)
                }
                Spacer()
                actionGroup
            }
            .padding(.horizontal)
        }
        .alert(isPresented: $trashAlertVisible) { trashAlert }
    }
}

// MARK: - Previews

#if DEBUG
struct JobListItemViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            JobListItemView(
                job: Job(
                    title: "Software Engineer",
                    company: "Apple",
                    dateApplied: Date(),
                    status: .applied
                )
            )
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
            JobListItemView(
                job: Job(
                    title: "Product Manager",
                    company: "Affinity, Inc.",
                    dateApplied: Date(),
                    status: .applied
                )
            )
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
        }
    }
}
#endif
