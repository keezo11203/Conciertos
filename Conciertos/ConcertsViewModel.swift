//
//  ConcertsViewModel.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/21/24.
//

import Foundation
import Combine

class ConcertsViewModel: ObservableObject {
    @Published var concerts: [Concert] = []

    func addConcert(_ concert: Concert) {
        concerts.append(concert)
    }
}
