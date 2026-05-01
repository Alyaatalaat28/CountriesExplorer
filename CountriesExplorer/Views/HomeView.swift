//
//  HomeView.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CountriesViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.indigo.opacity(0.9), Color.purple.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 48) {

                    Spacer()

                    VStack(spacing: 8) {
                        Text("🌍")
                            .font(.system(size: 80))
                        Text("Countries")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        Text("Explore the world")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }

                    if !viewModel.countries.isEmpty {
                        HStack(spacing: 24) {
                            StatPill(
                                value: "\(viewModel.countries.count)",
                                label: "Countries"
                            )
                            StatPill(
                                value: "\(viewModel.favouriteCountries.count)",
                                label: "Favourites"
                            )
                        }
                    }

                    VStack(spacing: 12) {
                        NavigationLink {
                            CountryListView(viewModel: viewModel)
                        } label: {
                            HomeButton(
                                icon: "globe",
                                title: "All Countries",
                                subtitle: "Browse and search"
                            )
                        }

                        NavigationLink {
                            FavouritesView(viewModel: viewModel)
                        } label: {
                            HomeButton(
                                icon: "heart.fill",
                                title: "Favourites",
                                subtitle: "\(viewModel.favouriteCountries.count) saved"
                            )
                        }
                    }
                    .padding(.horizontal, 32)

                    Spacer()
                }
            }
            .task {
                if viewModel.countries.isEmpty {
                    await viewModel.fetchCountries()
                }
            }
        }
    }
}

struct StatPill: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
}

struct HomeButton: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.indigo)
                .frame(width: 48, height: 48)
                .background(Color.white)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(16)
        .background(Color.white.opacity(0.15))
        .cornerRadius(16)
    }
}
