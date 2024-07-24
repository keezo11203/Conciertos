//
//  ConcertsViewModel.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation

class ConcertsViewModel: ObservableObject {
    @Published var concerts: [Concert] = []
    @Published var username: String = "user"
    @Published var bio: String = "This is my bio."
    @Published var favoriteAlbums: [String] = ["Album 1", "Album 2", "Album 3"]
    @Published var lastSeenArtist: String = ""
    
    // Ensure your functions like adding concerts update these properties correctly
    func addConcert(_ concert: Concert) {
        concerts.append(concert)
    }
}
