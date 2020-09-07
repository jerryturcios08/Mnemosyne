//
//  JobStore.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/7/20.
//

import SwiftUI

class JobStore: ObservableObject {
    @Published var jobs = [Job]()

    func createJob(with job: Job) {
        jobs.insert(job, at: 0)
    }

    func deleteJob(for id: UUID) {
        for (index, job) in jobs.enumerated() {
            if id == job.id {
                jobs.remove(at: index)
            }
        }
    }
}
