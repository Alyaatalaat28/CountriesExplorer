# 🌍 Countries Explorer

A countries browsing app built with SwiftUI. Built as a learning project to explore networking, async/await, and SwiftUI concepts.

## Features

- Browse all countries from the REST Countries API
- Search countries by name
- View detailed info: flag, capital, population, currency, languages, region
- Save favourite countries with persistent storage
- Loading and error states with retry support
- Flag images loaded asynchronously with AsyncImage

## Screens

- **Home** — entry point with navigation to countries list and favourites
- **Countries List** — searchable list showing flag, name, and region
- **Country Detail** — full country info with favourite toggle
- **Favourites** — saved countries with empty state handling
  
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 15 02 53" src="https://github.com/user-attachments/assets/7eb030d2-654d-473b-9040-abad1930f7d6" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 14 57 23" src="https://github.com/user-attachments/assets/21d4e8a5-9e53-4eb7-b608-3e09290fa20e" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 15 02 15" src="https://github.com/user-attachments/assets/85b71e25-cc9a-4285-ae73-4217ac05d49f" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 14 59 02" src="https://github.com/user-attachments/assets/831138a4-9689-4b30-ae9c-c6d24ce37316" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 14 59 35" src="https://github.com/user-attachments/assets/9d7a84f0-482f-4a39-b879-4e5517c7776f" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 14 57 41" src="https://github.com/user-attachments/assets/f4d53c41-5051-47b8-953e-0f2639903a29" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-05-01 at 15 02 58" src="https://github.com/user-attachments/assets/3a934157-5c4b-4453-8adb-8c5bccf88f7e" />

## Concepts Learned

| Concept | Where Used |
|---|---|
| `Codable` + `JSONDecoder` | Parsing API response in `Country.swift` |
| `URLSession.shared.data(from:)` | HTTP GET request in `CountryService.swift` |
| `async/await` with networking | Fetching data asynchronously |
| `do/try/catch` | Error handling in service and view model |
| `AsyncImage` | Loading flag images from URL |
| `enum ViewState` | Loading / error / success state management |
| `@AppStorage` | Persisting favourite countries |
| `.searchable()` | Search bar on countries list |
| `Task { }` in `.onAppear` | Triggering fetch on screen load |

## Tech Stack

- Swift 5.9+
- SwiftUI
- REST Countries API
- Xcode 16+
- iOS 17+
