//
//  Concert.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation

struct Concert: Identifiable {
    let id = UUID()
    var artist: String
    var tourName: String
    var venue: String
    var date: Date
}
