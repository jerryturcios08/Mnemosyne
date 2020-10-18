//
//  Achievement.swift
//  Mnemosyne
//
//  Created by Jerry Turcios on 10/17/20.
//

import Foundation

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var imageString: String
    var completed: Bool
}
