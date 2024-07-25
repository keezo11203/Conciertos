//
//  ContentView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ConcertsViewModel()

    var body: some View {
        TabView {
            AddConcertView(viewModel: viewModel)
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            ConcertsListView(viewModel: viewModel)
                .tabItem {
                    Label("Activity", systemImage: "bolt.fill")
                }
            UserProfileView(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
