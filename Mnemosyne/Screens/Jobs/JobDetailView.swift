//
//  JobDetailView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/10/20.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job?

    var body: some View {
        if let job = job {
            VStack {
                Text(job.title)
                Text(job.company)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(job.title)
        } else {
            VStack {
                Text("No job is selected.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Detail")
        }
    }
}

struct JobDetailView_Previews: PreviewProvider {
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
