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

    var body: some View {
        Form {
            TextField("Artist", text: $artist)
            TextField("Tour Name", text: $tourName)
            TextField("Venue", text: $venue)
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Button("Save Concert") {
                let isUpcoming = date > Date()
                let newConcert = Concert(artist: artist, tourName: tourName, venue: venue, date: date, isUpcoming: isUpcoming)
                viewModel.addConcert(newConcert)

                // Reset form fields
                artist = ""
                tourName = ""
                venue = ""
                date = Date()
            }
        }
        .navigationTitle("Add Concert")
    }
}
