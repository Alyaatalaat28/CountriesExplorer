//
//  CountryDetailView.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    @ObservedObject var viewModel: CountriesViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                AsyncImage(url: country.flagURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 220)
                            .clipped()
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 220)
                            .overlay(ProgressView())
                    }
                }

                VStack(spacing: 4) {
                    Text(country.commonName)
                        .font(.system(size: 28, weight: .bold))
                    Text(country.name.official)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                .padding(.horizontal)

                VStack(spacing: 12) {
                    InfoCard(items: [
                        InfoItem(icon: "mappin.circle.fill",  label: "Capital",    value: country.capitalText,    color: .red),
                        InfoItem(icon: "globe.americas.fill", label: "Region",     value: country.region,         color: .blue),
                        InfoItem(icon: "map.fill",            label: "Subregion",  value: country.subregion ?? "N/A", color: .teal),
                    ])

                    InfoCard(items: [
                        InfoItem(icon: "person.3.fill",       label: "Population", value: country.formattedPopulation, color: .orange),
                        InfoItem(icon: "banknote.fill",       label: "Currency",   value: country.currencyText,   color: .green),
                        InfoItem(icon: "text.bubble.fill",    label: "Languages",  value: country.languageText,   color: .purple),
                    ])
                }
                .padding(16)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation(.spring()) {
                        viewModel.toggleFavourite(country)
                    }
                } label: {
                    Image(systemName: viewModel.isFavourite(country)
                          ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.title3)
                }
            }
        }
    }
}

struct InfoCard: View {
    let items: [InfoItem]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                HStack(spacing: 12) {
                    Image(systemName: item.icon)
                        .foregroundColor(item.color)
                        .frame(width: 28)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.label)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(item.value)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                if index < items.count - 1 {
                    Divider().padding(.leading, 56)
                }
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

struct InfoItem {
    let icon: String
    let label: String
    let value: String
    let color: Color
}
