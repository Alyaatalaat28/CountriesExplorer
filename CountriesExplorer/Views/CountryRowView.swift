//
//  CountryRowView.swift
//  CountriesExplorer
//
//  Created by Alyaa on 5/1/26.
//

import SwiftUI

struct CountryRowView: View {
    let country: Country
    let isFavourite: Bool

    var body: some View {
        HStack(spacing: 16) {

            AsyncImage(url: country.flagURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 56, height: 38)
                        .overlay(ProgressView().scaleEffect(0.6))

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(color: .black.opacity(0.1), radius: 4)

                case .failure:
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 56, height: 38)
                        .overlay(Text("🏳️").font(.title2))

                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(country.commonName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(country.region)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.indigo.opacity(0.1))
                    .clipShape(Capsule())
            }

            Spacer()

            if isFavourite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.4))
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
}
