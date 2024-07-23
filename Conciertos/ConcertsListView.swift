//
//  ConcertsListView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation
import SwiftUI

struct ConcertsListView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Upcoming Concerts")) {
                    ForEach(upcomingConcerts) { concert in
                        ConcertRow(concert: concert, isUpcoming: true)
                    }
                }

                Section(header: Text("Past Concerts")) {
                    ForEach(pastConcerts) { concert in
                        ConcertRow(concert: concert, isUpcoming: false)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationBarTitle("Concerts")
        }
    }

    private var upcomingConcerts: [Concert] {
        viewModel.concerts.filter { $0.date >= Date() }.sorted { $0.date < $1.date }
    }

    private var pastConcerts: [Concert] {
        viewModel.concerts.filter { $0.date < Date() }.sorted { $0.date > $1.date }
    }
}

struct ConcertRow: View {
    var concert: Concert
    var isUpcoming: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(concert.artist).font(.headline)
                Text(concert.tourName).font(.subheadline)
                Text(concert.venue)
                Text("Date: \(concert.date, formatter: itemFormatter)")
            }
            Spacer()
            if isUpcoming {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background(isUpcoming ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
