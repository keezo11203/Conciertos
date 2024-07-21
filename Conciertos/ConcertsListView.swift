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
        List(viewModel.concerts) { concert in
            VStack(alignment: .leading) {
                Text(concert.artist).font(.headline)
                Text(concert.tourName)
                Text("\(concert.city), \(concert.state) - \(concert.venue)")
                Text("Date: \(concert.date, formatter: itemFormatter)")
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Recent Concerts")
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}
