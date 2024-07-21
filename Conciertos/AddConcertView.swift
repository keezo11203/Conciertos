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
    @State private var city = ""
    @State private var state = ""
    @State private var venue = ""
    @State private var date = Date()

    var body: some View {
        Form {
            TextField("Artist", text: $artist)
            TextField("Tour Name", text: $tourName)
            TextField("City", text: $city)
            TextField("State", text: $state)
            TextField("Venue", text: $venue)
            DatePicker("Date", selection: $date, displayedComponents: .date)
            Button("Save Concert") {
                let newConcert = Concert(artist: artist, tourName: tourName, city: city, state: state, venue: venue, date: date)
                viewModel.addConcert(newConcert)
            }
        }
        .navigationTitle("Add Concert")
    }
}
