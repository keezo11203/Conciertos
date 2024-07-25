//
//  ConcertsListView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation
import Foundation
import SwiftUI

struct ConcertsListView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var isUpcomingConcertsExpanded: Bool = true
    @State private var isPastConcertsExpanded: Bool = true

    var body: some View {
        ScrollView {
            VStack {
                Text("Total Concerts: \(viewModel.concerts.count)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)

                Divider()

                DisclosureGroup(
                    "Upcoming Concerts",
                    isExpanded: $isUpcomingConcertsExpanded
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.sortedUpcomingConcerts) { concert in
                                concertEntryView(concert, isStarred: viewModel.isMostUpcoming(concert: concert))
                            }
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                DisclosureGroup(
                    "Past Concerts",
                    isExpanded: $isPastConcertsExpanded
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.sortedPastConcerts) { concert in
                                concertEntryView(concert, isStarred: false)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.gray.opacity(0.05))
        .navigationTitle("Activity")
    }

    private func concertEntryView(_ concert: Concert, isStarred: Bool) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if isStarred {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                Text(concert.artist)
                    .font(.headline)
                    .fontWeight(isStarred ? .bold : .regular) // Bold for starred concert
            }
            Text(concert.tourName)
                .font(.subheadline)
            Text(concert.venue)
            Text("Date: \(concert.date, formatter: itemFormatter)")
                .font(.caption)
        }
        .padding()
        .background(isStarred ? Color.blue.opacity(0.2) : Color.white) // Different background for starred concert
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isStarred ? Color.blue : Color.clear, lineWidth: 2) // Highlighted border for starred concert
        )
        .shadow(color: isStarred ? Color.blue.opacity(0.5) : Color.clear, radius: 3, x: 0, y: 2) // Optional shadow for emphasis
        .padding(.vertical, 2)
    }

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

extension ConcertsViewModel {
    var sortedUpcomingConcerts: [Concert] {
        concerts.filter { $0.isUpcoming }.sorted(by: { $0.date < $1.date })
    }

    var sortedPastConcerts: [Concert] {
        concerts.filter { !$0.isUpcoming }.sorted(by: { $0.date > $1.date })
    }

    func isMostUpcoming(concert: Concert) -> Bool {
        guard let first = sortedUpcomingConcerts.first else { return false }
        return concert.id == first.id
    }
}
