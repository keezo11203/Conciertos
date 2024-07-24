//
//  UserProfileView.swift
//  Conciertos
//
//  Created by Kaitlyn Ellis on 7/24/24.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @State private var profileImage = Image("defaultProfilePic") // Placeholder image
    @State private var username: String = "user"
    @State private var bio: String = "bio"
    @State private var favoriteAlbums: [String] = ["Album 1", "Album 2", "Album 3", "Album 4"]

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeader(profileImage: $profileImage, username: $username, bio: $bio)
                FavoritesSection(favoriteAlbums: $favoriteAlbums)
                FavoriteLivePerformersView() // Shows favorite live performers
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileHeader: View {
    @Binding var profileImage: Image
    @Binding var username: String
    @Binding var bio: String

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
    @Binding var favoriteAlbums: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Albums") // Updated text label
                .font(.headline)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(favoriteAlbums, id: \.self) { album in
                        VStack {
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 2))
                            Text(album)
                                .font(.caption)
                                .padding(.top, 4)
                        }
                        .padding(.leading)
                    }
                }
            }
        }
    }
}

struct FavoriteLivePerformersView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Live Performers")
                .font(.headline)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { index in
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .background(Color.gray.opacity(0.3))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.vertical)

                            Text("Performer \(index + 1)")
                                .font(.caption)
                        }
                        .padding(.leading)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
