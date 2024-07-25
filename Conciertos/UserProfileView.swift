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
            Text("Favorite Albums")
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(favoriteAlbums, id: \.self) { album in
                        VStack {
                            Image(systemName: "photo.on.rectangle.angled") // Placeholder for album art
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .background(Color.gray.opacity(0.3)) // Light gray background for the image
                                .cornerRadius(8)
                                .clipped()

                            Text(album)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .frame(width: 120) // Ensure the text is centered and wrapped within the image width
                                .lineLimit(2) // Limit text to two lines
                        }
                        .padding(.vertical, 10)
                        .background(Color.white) // Background color of the card
                        .cornerRadius(10) // Rounded corners for the card
                        .shadow(radius: 5) // Shadow for a 3D effect
                        .padding(.leading, 10)
                    }
                }
                .padding(.horizontal)
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


struct ArtistView: View {
    var artistName: String
    var artistImage: Image?  // Make it optional to handle cases where the image might not be set

    var body: some View {
        VStack {
            (artistImage ?? Image(systemName: "person.circle.fill"))  // Using a system image as a placeholder
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

struct UserProfileView: View {
    @ObservedObject var viewModel: ConcertsViewModel
    @State private var profileImage = Image(systemName: "person.circle")  // Using a system image as a placeholder for the profile picture

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeader(profileImage: profileImage, username: viewModel.username, bio: viewModel.bio)
                FavoritesAlbumsGrid(favoriteAlbums: viewModel.favoriteAlbums)
                HStack(spacing: 40) {
                    ArtistView(artistName: "Last Seen: \(viewModel.lastSeenArtist)", artistImage: nil)  // No artistImage provided, will use placeholder
                    ArtistView(artistName: "Upcoming: \(viewModel.upcomingArtist)", artistImage: nil)  // No artistImage provided, will use placeholder
                }
                .padding(.top, 20)
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}
