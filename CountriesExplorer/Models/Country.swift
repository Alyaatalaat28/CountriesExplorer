//
//  Country.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import Foundation

struct Country: Codable, Identifiable, Hashable {
    let id: UUID = UUID()

    let name: Name
    let capital: [String]?
    let population: Int
    let region: String
    let subregion: String?
    let flags: Flags
    let currencies: [String: Currency]?
    let languages: [String: String]?
    let area: Double?

    var commonName: String { name.common }

    var capitalText: String {
        capital?.joined(separator: ", ") ?? "N/A"
    }

    var currencyText: String {
        guard let currencies else { return "N/A" }
        return currencies.values
            .map { "\($0.name) (\($0.symbol ?? ""))" }
            .joined(separator: ", ")
    }

    var languageText: String {
        guard let languages else { return "N/A" }
        return languages.values.sorted().joined(separator: ", ")
    }

    var formattedPopulation: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: population)) ?? "\(population)"
    }

    var flagURL: URL? { URL(string: flags.png) }

    enum CodingKeys: String, CodingKey {
        case name, capital, population, region
        case subregion, flags, currencies, languages, area
    }
}

struct Name: Codable, Hashable {
    let common: String
    let official: String
}

struct Flags: Codable, Hashable {
    let png: String
    let svg: String
}

struct Currency: Codable, Hashable {
    let name: String
    let symbol: String?
}

