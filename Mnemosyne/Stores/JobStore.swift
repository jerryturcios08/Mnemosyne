//
//  JobStore.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 9/7/20.
//

import SwiftUI

class JobStore: ObservableObject {
    // MARK: - Properties

    @Published var jobs = [Job]()

    // MARK: - Methods

    func createJob(with job: Job) {
        jobs.insert(job, at: 0)
        saveJobs()
    }

    func deleteJob(for id: UUID) {
        for (index, job) in jobs.enumerated() {
            if id == job.id {
                jobs.remove(at: index)
                saveJobs()
            }
        }
    }

    func editJob(with updatedJob: Job) {
        for (index, job) in jobs.enumerated() {
            if updatedJob.id == job.id {
                jobs[index] = updatedJob
                saveJobs()
            }
        }
    }

    func editJobNotes(with notes: String, for id: UUID) {
        for (index, job) in jobs.enumerated() {
            if id == job.id {
                jobs[index].notes = notes
                saveJobs()
            }
        }
    }

    func toggleFavorite(for id: UUID) {
        for (index, job) in jobs.enumerated() {
            if id == job.id {
                jobs[index].favorite.toggle()
                saveJobs()
            }
        }
    }

    // MARK: - Local storage

    func saveJobs() {
        do {
            let data = try JSONEncoder().encode(jobs)
            UserDefaults.standard.set(data, forKey: Key.jobs)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func loadJobs() {
        guard let savedData = UserDefaults.standard.object(forKey: Key.jobs) as? Data else { return }

        do {
            jobs = try JSONDecoder().decode([Job].self, from: savedData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
