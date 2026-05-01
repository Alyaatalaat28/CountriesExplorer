//
//  CountryService.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(Int)
    case unknown(Error)

    var message: String {
        switch self {
        case .invalidURL:          return "Invalid URL"
        case .invalidResponse:     return "Invalid server response"
        case .decodingError(let e): return "Failed to decode data: \(e.localizedDescription)"
        case .serverError(let code): return "Server error: \(code)"
        case .unknown(let e):      return e.localizedDescription
        }
    }
}

class CountryService {
    static let shared = CountryService()
    private init() { }

    private let baseURL = "https://restcountries.com/v3.1"

    func fetchAllCountries() async throws -> [Country] {
        let url = try makeURL(path: "/all?fields=name,capital,population,region,subregion,flags,currencies,languages,area")

        let (data, response) = try await URLSession.shared.data(from: url)

        try validateResponse(response)

        do {
            let decoder = JSONDecoder()
            var countries = try decoder.decode([Country].self, from: data)
            countries.sort { $0.commonName < $1.commonName }
            return countries
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    func fetchCountries(byRegion region: String) async throws -> [Country] {
        let url = try makeURL(path: "/region/\(region)?fields=name,capital,population,region,flags")
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        return try JSONDecoder().decode([Country].self, from: data)
    }

    private func makeURL(path: String) throws -> URL {
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        return url
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
    }
}
