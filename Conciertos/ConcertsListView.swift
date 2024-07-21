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
    @State private var isSortedDescending = true

    var body: some View {
        NavigationView {
            List(filteredAndSortedConcerts) { concert in
                VStack(alignment: .leading) {
                    Text(concert.artist).font(.headline)
                    Text(concert.tourName)
                    Text("\(concert.city), \(concert.state) - \(concert.venue)")
                    Text("Date: \(concert.date, formatter: itemFormatter)")
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle("Recent Concerts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSortedDescending.toggle()
                    }) {
                        Image(systemName: isSortedDescending ? "arrow.up.arrow.down.circle.fill" : "arrow.down.arrow.up.circle.fill")
                    }
                }
            }
        }
    }

    private var filteredAndSortedConcerts: [Concert] {
        let filtered = searchText.isEmpty ? viewModel.concerts : viewModel.concerts.filter { concert in
            concert.artist.lowercased().contains(searchText.lowercased()) ||
            concert.city.lowercased().contains(searchText.lowercased()) ||
            concert.tourName.lowercased().contains(searchText.lowercased())
        }
        return filtered.sorted {
            isSortedDescending ? $0.date > $1.date : $0.date < $1.date
        }
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}
