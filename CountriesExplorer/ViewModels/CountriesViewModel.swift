//
//  CountriesViewModel.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//
import SwiftUI
import Combine

enum ViewState {
    case idle
    case loading
    case success
    case error(String)
}

@MainActor
class CountriesViewModel: ObservableObject {

    // ── Published State ──
    @Published var countries: [Country] = []
    @Published var searchText: String = ""
    @Published var viewState: ViewState = .idle
    @Published var selectedRegion: String = "All"
    @Published var favouriteNames: Set<String> = []

    // ── Computed ──
    var regions: [String] {
        let all = Set(countries.map { $0.region }).sorted()
        return ["All"] + all
    }

    var filteredCountries: [Country] {
        var result = countries

        if selectedRegion != "All" {
            result = result.filter { $0.region == selectedRegion }
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.commonName.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result
    }

    var favouriteCountries: [Country] {
        countries.filter { isFavourite($0) }
    }

    init() {
        loadFavourites()
    }

    
    func fetchCountries() async {
        viewState = .loading
        do {
            countries = try await CountryService.shared.fetchAllCountries()
            viewState = .success
        } catch let error as NetworkError {
            viewState = .error(error.message)
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }

   
    func isFavourite(_ country: Country) -> Bool {
        favouriteNames.contains(country.commonName)
    }

    func toggleFavourite(_ country: Country) {
        if favouriteNames.contains(country.commonName) {
            favouriteNames.remove(country.commonName)
        } else {
            favouriteNames.insert(country.commonName)
        }
        saveFavourites()
    }

   
    private func saveFavourites() {
        let array = Array(favouriteNames)
        UserDefaults.standard.set(array, forKey: "favourites")
    }

    private func loadFavourites() {
        let array = UserDefaults.standard.stringArray(forKey: "favourites") ?? []
        favouriteNames = Set(array)
    }
}
