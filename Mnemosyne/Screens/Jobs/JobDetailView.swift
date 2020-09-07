//
//  JobDetailView.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/7/20.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job

    var body: some View {
        VStack {
            Text("")
        }
        .navigationTitle(job.company)
    }
}

#if DEBUG
struct JobDetailViewPreviews: PreviewProvider {
    static var previews: some View {
        JobDetailView(
            job: Job(
                title: "Software Engineer",
                company: "Apple",
                dateApplied: Date(),
                status: .applied
            )
        )
    }
}
#endif
