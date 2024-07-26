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

struct RecentConcertsView: View {
    var concerts: [Concert]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Concerts").font(.headline).padding()
            ForEach(concerts) { concert in
                Text("\(concert.artist) - \(concert.date.formatted(date: .abbreviated, time: .omitted))")
            }
        }
        .padding()
    }
}


struct ArtistView: View {
    var artistName: String
    var artistImage: Image

    var body: some View {
        VStack {
            artistImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
            Text(artistName)
                .font(.caption)
        }
    }
}

struct FavoriteArtistView: View {
    var artistName: String
    var artistImage: Image

    var body: some View {
        VStack {
            Text("Favorite Artist Seen Live").font(.headline)
            artistImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            Text(artistName).font(.headline)
        }
        .padding()
    }
}

struct FavoritesAlbumsGrid: View {
    var favoriteAlbums: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Albums")
                .font(.headline)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(favoriteAlbums, id: \.self) { album in
                        VStack {
                            Rectangle()  // Blank placeholder for album cover
                                .fill(Color.gray.opacity(0.3))  // Light gray fill
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)  // Rounded corners

                            Text(album)
                                .font(.caption)
                                .frame(width: 120)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 10)
                        .background(Color.white)  // Background color of the card
                        .cornerRadius(10)  // Rounded corners of the card
                        .shadow(radius: 3)  // Shadow for depth
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct UserProfileView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var profileImage = Image(systemName: "person.circle")  // Using a system image as a placeholder for the profile picture

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileHeader(profileImage: profileImage, username: viewModel.username, bio: viewModel.bio)
                FavoritesAlbumsGrid(favoriteAlbums: viewModel.favoriteAlbums)
                
                // Concerts Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Concerts")
                        .font(.headline)
                        .padding(.bottom, 5)

                    // Last Seen and Upcoming artists
                    HStack(spacing: 40) {
                        ArtistView(artistName: "Last Seen: \(viewModel.lastSeenArtist)", artistImage: Image(systemName: "person.crop.circle"))  // Assuming placeholder
                        ArtistView(artistName: "Upcoming: \(viewModel.upcomingArtist)", artistImage: Image(systemName: "person.crop.circle"))  // Assuming placeholder
                    }

                    // Favorite Artist Seen Live
                    FavoriteArtistView(artistName: viewModel.favoriteArtistSeenLive, artistImage: Image(systemName: "star.fill"))
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}
