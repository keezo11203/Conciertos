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

    var body: some View {
        ScrollView {
            VStack {
                Text("Total Concerts: \(viewModel.concerts.count)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)

                Divider()

                DisclosureGroup("Upcoming Concerts", isExpanded: .constant(true)) {
                    ForEach(viewModel.concerts.filter { $0.isUpcoming }) { concert in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(concert.artist)
                                .font(.headline)
                            Text(concert.tourName)
                                .font(.subheadline)
                            Text(concert.venue)
                            Text("Date: \(concert.date, formatter: itemFormatter)")
                                .font(.caption)
                            if concert.isUpcoming {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.vertical, 2)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                DisclosureGroup("Past Concerts") {
                    ForEach(viewModel.concerts.filter { !$0.isUpcoming }) { concert in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(concert.artist)
                                .font(.headline)
                            Text(concert.tourName)
                                .font(.subheadline)
                            Text(concert.venue)
                            Text("Date: \(concert.date, formatter: itemFormatter)")
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                        .padding(.vertical, 2)
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

    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}
