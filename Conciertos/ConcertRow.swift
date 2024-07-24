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

    var body: some View {
        VStack(alignment: .leading) {
            Text(concert.artist).font(.headline)
            Text(concert.tourName).font(.subheadline)
            Text("At \(concert.venue) on \(concert.date.formatted())")
            if concert.isUpcoming {
                Text("Upcoming").foregroundColor(.blue)
            }
        }
    }
}
