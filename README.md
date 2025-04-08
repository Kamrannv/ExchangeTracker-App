# 💱 ExchangeTracker

A SwiftUI app to track real-time exchange rates for selected assets (fiat & crypto), with persistence(SwiftData), auto-refresh, and a clean code architecture(unit/ui tests included).

---

## 🛠 Features

- Add/remove fiat or cryptocurrency assets
- View live exchange rates (auto-refresh every 5 seconds)
- Offline persistence with SwiftData
- Clean MVI architecture
- Modular SwiftData + use case + DI setup
- Test coverage for ViewModels with:
  - ✅ Unit tests (Swift Testing)
  - ✅ UI tests (Page Object pattern via `AppRobot`)

---

## 📦 API Used

- **[CoinGecko API](https://api.coingecko.com/api/v3)**  
  - `/simple/price` for rates  
  - `/simple/supported_vs_currencies` for asset list  

> You can replace the "x-cg-demo-api-key" key with yours in `ExchangeEndPoints`.

---

## ⚙️ Setup Instructions

1. Clone the repository or unzip the provided file.
2. Open `ExchangeTracker.xcodeproj` in Xcode.
3. Run the app on **iOS 17+** (built with SwiftData & iOS 17 APIs).
4. Replace `app_id` in `ExchangeEndPoints.swift` with your `app_id` key if it does not work for you.

---

## 🧪 Testing

### ✅ Unit Tests

- Located in `ExchangeTrackerTests`
- Written using **Swift Testing framework**
- Covers `HomeViewModel`, `AddAssetViewModel`

### ✅ UI Tests

- Located in `ExchangeTrackerUITests`
- Built using the **Page Object Pattern** via:
  - `AppRobot`
  - `HomeRobot`
  - `AddAssetRobot`
- Simulates adding an asset and verifying UI state

## 📱 Minimum Requirements

- Xcode 15+
- iOS 17+
- SwiftData-compatible device or simulator

---

## 🧼 Architecture

- **MVI (Model–View–Intent)** inspired
- Use Cases decoupled from Repositories
- SwiftData used for caching selected assets
- State-driven UI using `@StateObject` containers

---

## 👨‍💻 Author

Kamran Namazov  

---

