//
//  ConcertsViewModel.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation

class ConcertsViewModel: ObservableObject {
    @Published var concerts: [Concert] = []
    @Published var username: String = "Default User"
    @Published var bio: String = "This is a bio."
    @Published var favoriteAlbums: [String] = ["", "", ""]
    @Published var lastSeenArtist: String = ""
    @Published var upcomingArtist: String = ""
    @Published var favoriteArtistSeenLive: String = ""  
    // Function to add a concert
    func addConcert(_ concert: Concert) {
        concerts.append(concert)
        updateArtists()
    }

    // Function to update last seen and upcoming artists based on concert dates
    private func updateArtists() {
        // Determine the last seen artist
        if let lastSeen = concerts.filter({ $0.date < Date() }).max(by: { $0.date < $1.date }) {
            lastSeenArtist = lastSeen.artist
        }

        // Determine the upcoming artist
        if let upcoming = concerts.filter({ $0.date > Date() }).min(by: { $0.date < $1.date }) {
            upcomingArtist = upcoming.artist
        }
    }

    // Function to set favorite albums
    func setFavoriteAlbums(_ albums: [String]) {
        favoriteAlbums = albums
    }
}
