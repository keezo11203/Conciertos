//
//  ConcertRow.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/22/24.
//

import Foundation
import SwiftUI

struct ConcertRow: View {
    var concert: Concert
    var isUpcoming: Bool
    @State private var showingActionSheet = false

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
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
        .padding()
        .background(isUpcoming ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
        .cornerRadius(10)
        .onTapGesture {
            showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("\(concert.artist) - \(concert.tourName)"), // Title combines artist and tour name
                message: Text("Choose an action"), // General prompt for actions
                buttons: [
                    .default(Text("View Artist")) {
                        print("Viewing details for \(concert.artist)")
                    },
                    .default(Text("View Tour Details")) {
                        print("Viewing details for \(concert.tourName)")
                    },
                    .default(Text("View Venue Details")) {
                        print("Viewing details at \(concert.venue)")
                    },
                    .cancel()
                ]
            )
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
