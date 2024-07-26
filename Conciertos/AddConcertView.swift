//
//  AddConcertView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation
import SwiftUI

struct AddConcertView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var artist = ""
    @State private var tourName = ""
    @State private var venue = ""
    @State private var date = Date()
    @State private var tempFavoriteAlbums: [String] = []
    @State private var tempFavoriteArtist: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Concert Details")) {
                    TextField("Artist", text: $artist)
                    TextField("Tour Name", text: $tourName)
                    TextField("Venue", text: $venue)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    Button("Save Concert Details") {
                        saveConcertDetails()
                    }
                }

                Section(header: Text("Favorite Albums")) {
                    ForEach(tempFavoriteAlbums.indices, id: \.self) { index in
                        TextField("Album \(index + 1)", text: $tempFavoriteAlbums[index])
                    }
                    .onDelete(perform: deleteAlbum)

                    if tempFavoriteAlbums.count < 3 {
                        Button("Add Album") {
                            tempFavoriteAlbums.append("")
                        }
                    }
                    Button("Save Favorite Albums") {
                        viewModel.favoriteAlbums = tempFavoriteAlbums
                    }
                }

                Section(header: Text("Favorite Artist Seen Live")) {
                    TextField("Artist Name", text: $tempFavoriteArtist)
                    Button("Save Favorite Artist") {
                        viewModel.favoriteArtistSeenLive = tempFavoriteArtist
                    }
                }
            }
            .navigationBarTitle("Add Details")
            .onAppear {
                tempFavoriteAlbums = viewModel.favoriteAlbums
                tempFavoriteArtist = viewModel.favoriteArtistSeenLive
            }
        }
    }

    private func saveConcertDetails() {
        let isUpcoming = date > Date()
        let newConcert = Concert(artist: artist, tourName: tourName, venue: venue, date: date, isUpcoming: isUpcoming)
        viewModel.addConcert(newConcert)

        // Reset form fields
        artist = ""
        tourName = ""
        venue = ""
        date = Date()
    }

    private func deleteAlbum(at offsets: IndexSet) {
        tempFavoriteAlbums.remove(atOffsets: offsets)
    }
}
