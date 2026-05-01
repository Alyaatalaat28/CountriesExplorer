//
//  FavouritesView.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var viewModel: CountriesViewModel

    var body: some View {
        Group {
            if viewModel.favouriteCountries.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 56))
                        .foregroundColor(.gray.opacity(0.3))
                    Text("No Favourites Yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Tap the heart on any country\nto save it here")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.favouriteCountries) { country in
                    NavigationLink {
                        CountryDetailView(
                            country: country,
                            viewModel: viewModel
                        )
                    } label: {
                        CountryRowView(
                            country: country,
                            isFavourite: true
                        )
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("❤️ Favourites")
    }
}
