//
//  UserProfileView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/24/24.
//

import SwiftUI

struct ProfileHeader: View {
    var profileImage: Image
    var username: String
    var bio: String

    var body: some View {
        VStack {
            profileImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .padding(.top, 20)
            Text(username).font(.title).bold()
            Text(bio).font(.subheadline).italic()
        }
    }
}

struct FavoritesSection: View {
    var favoriteAlbums: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Albums").font(.headline).padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(favoriteAlbums, id: \.self) { album in
                        Text(album).padding()
                    }
                }
            }
        }
    }
}

struct RecentConcertsView: View {
    var concerts: [Concert]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Concerts").font(.headline)
            ForEach(concerts) { concert in
                Text("\(concert.artist) - \(concert.date.formatted(date: .abbreviated, time: .omitted))")
            }
        }
        .padding()
    }
}

struct LastSeenLiveView: View {
    var artist: String

    var body: some View {
        Text("Last Seen Live: \(artist)").padding()
    }
}

struct UserProfileView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var profileImage = Image("defaultProfilePic")

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeader(profileImage: profileImage, username: viewModel.username, bio: viewModel.bio)
                FavoritesSection(favoriteAlbums: viewModel.favoriteAlbums)
                RecentConcertsView(concerts: viewModel.concerts)
                LastSeenLiveView(artist: viewModel.lastSeenArtist)
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}
