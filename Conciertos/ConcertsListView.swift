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
        List(viewModel.concerts) { concert in
            ConcertRow(concert: concert)
        }
        .navigationTitle("Concerts List")
    }
}
