//
//  AchievementStore.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 10/17/20.
//

import Foundation

class AchievementStore: ObservableObject {
    // MARK: - Properties

    @Published var jobsAppliedCount = 0
    @Published var appSharedCount = 0
    @Published var hasRecievedOffer = false
    @Published var hasRecievedRejection = false

    let achievements: [Achievement] = [
        .init(title: "Rookie", imageString: "Rookie", completed: false),
        .init(title: "I plead the fifth", imageString: "TheFifth", completed: false),
        .init(title: "Twenty", imageString: "Twenty", completed: false),
        .init(title: "Hundred", imageString: "Hundred", completed: false),
        .init(title: "Don't stop me now", imageString: "DontStopMeNow", completed: false),
        .init(title: "Victory", imageString: "Victory", completed: false),
        .init(title: "Mission failed", imageString: "MissionFailed", completed: false),
        .init(title: "I bring good news", imageString: "GoodNews", completed: false)
    ]
}
