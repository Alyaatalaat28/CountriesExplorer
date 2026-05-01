//
//  CountryListView.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var viewModel: CountriesViewModel

    var body: some View {
        Group {
            switch viewModel.viewState {

            case .idle, .loading:
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.4)
                    Text("Loading countries...")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .error(let message):
                VStack(spacing: 16) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    Text("Something went wrong")
                        .font(.headline)
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button("Try Again") {
                        Task { await viewModel.fetchCountries() }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .success:
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewModel.regions, id: \.self) { region in
                                Button {
                                    withAnimation {
                                        viewModel.selectedRegion = region
                                    }
                                } label: {
                                    Text(region)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(
                                            viewModel.selectedRegion == region
                                            ? .white : .indigo
                                        )
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(
                                            viewModel.selectedRegion == region
                                            ? Color.indigo
                                            : Color.indigo.opacity(0.1)
                                        )
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }

                    Divider()

                    if viewModel.filteredCountries.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(.gray.opacity(0.4))
                            Text("No countries found")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(viewModel.filteredCountries) { country in
                            NavigationLink {
                                CountryDetailView(
                                    country: country,
                                    viewModel: viewModel
                                )
                            } label: {
                                CountryRowView(
                                    country: country,
                                    isFavourite: viewModel.isFavourite(country)
                                )
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("🌍 Countries")
        .searchable(
            text: $viewModel.searchText,
            prompt: "Search countries..."
        )
        .task {
            if viewModel.countries.isEmpty {
                await viewModel.fetchCountries()
            }
        }
    }
}
