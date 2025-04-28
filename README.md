# Toropal - Finch Money Transfer App

Finch (formerly Toropal) is a Flutter-based mobile application designed for fast, secure, and global money transfers, leveraging modern technology for a seamless user experience.

## Features

*   **User Authentication**: Secure sign-up and login.
*   **Balance Management**: View current balance and add funds.
*   **Money Transfer**: Send money globally with competitive rates (integration pending).
*   **Transaction History**: Track and view past transactions with status updates.
*   **Budgeting Tools**: Manage personal budgets (details in `BudgetScreen`).
*   **Savings Goals**: Set and track savings goals (details in `SavingsGoalsScreen`).
*   **Social Payments**: Features for splitting bills or sending money to contacts (details in `SocialPaymentScreen`).
*   **Eco-Friendly Features**: Track carbon footprint, explore green investments, and donate to environmental causes (details in `EcoFriendlyScreen`).
*   **(Planned)** Blockchain Integration: Secure transactions using blockchain technology.
*   **(Planned)** Real-time Exchange Rates: Access current exchange rates for transfers.

## Architecture Overview

This application primarily uses the **BLoC (Business Logic Component)** pattern for state management, separating UI from business logic.

*   **`lib/bloc`**: Contains BLoC classes for managing the state of different features (Authentication, Balance, Budget, Transactions, etc.).
*   **`lib/models`**: Defines the data structures (e.g., `Transaction`, `UserBalance`, `Budget`).
*   **`lib/screens`**: Contains the main UI screens for different parts of the application.
*   **`lib/services`**: Includes service classes that handle business logic, data fetching (currently mocked/simulated), and interactions with potential backend APIs or blockchain networks (e.g., `TransactionService`, `BalanceService`).
*   **`lib/main.dart`**: The entry point of the application, setting up initial routing and providers.

## Getting Started

### Prerequisites

*   **Flutter SDK**: Version 3.0.0 or higher recommended. Install from [Flutter official website](https://flutter.dev/docs/get-started/install).
*   **Dart SDK**: Bundled with Flutter.
*   **IDE**: Android Studio or VS Code (with Flutter and Dart plugins).
*   **Platform SDKs**:
    *   **Android**: Android SDK (install via Android Studio).
    *   **iOS/macOS**: Xcode (install from Mac App Store).
*   **Git**: For cloning the repository.

### Installation & Setup

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/toropaal.git # Replace with your repo URL if different
    cd toropal
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app** (select a device or emulator):
    ```bash
    flutter run
    ```

## Running Tests

Currently, the project includes basic widget tests. To run them:

```bash
flutter test
```

*(Note: Comprehensive unit and integration tests are planned for future development)*

## Building for Release

### Android

```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```
*(Ensure you have set up signing keys as per Flutter documentation)*

### iOS

```bash
flutter build ipa --release
```
*(Requires Xcode setup and an Apple Developer account)*

## API Documentation

Details regarding backend APIs or blockchain interactions are currently handled by mock services within the `lib/services/` directory. As real backend services are integrated, API documentation will be provided separately.

## Project Structure

```
lib/
├── bloc/             # BLoC pattern implementations for state management
│   ├── authentication/
│   ├── balance/
│   ├── budget/
│   ├── onboarding/
│   ├── social_payment/
│   ├── splash/
│   └── transaction/
├── main.dart         # App entry point
├── models/           # Data models (Transaction, UserBalance, etc.)
├── screens/          # UI Screens (HomeScreen, AuthScreen, etc.)
└── services/         # Business logic, data fetching, API interaction
```

## Contributing

Contributions are welcome! Please follow standard Git workflow (fork, branch, pull request).

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
