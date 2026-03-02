# Expense Tracker (iOS SwiftUI)

A small, sleek iOS expense tracker app focused on the core inputs:
- Deposit / Withdrawal
- Amount
- Reason
- Category

## Features
- Quick segmented control to switch between **Deposit** and **Withdrawal**.
- Add entries with amount, reason, and category.
- Running totals for deposits, withdrawals, and live balance.
- Clean SwiftUI card-based layout with iOS-style materials.
- Recent entries list with date and color-coded amounts.

## Project structure
- `ExpenseTracker/ExpenseTrackerApp.swift` – app entry point.
- `ExpenseTracker/Views/ContentView.swift` – main sleek UI.
- `ExpenseTracker/ViewModels/ExpenseTrackerViewModel.swift` – UI-facing state and calculations.
- `ExpenseTracker/Models/Transaction.swift` – app transaction model and entry type.
- `Sources/ExpenseTrackerCore/ExpenseLedger.swift` – testable business logic module.
- `Tests/ExpenseTrackerCoreTests/ExpenseLedgerTests.swift` – unit tests for add/validate/calculate flows.

## Validation
- Core behavior is validated with `swift test` in this repository.
- iOS UI should be run from Xcode on macOS (SwiftUI apps cannot be launched from this Linux container).

## Next enhancements
- Persist entries using SwiftData or Core Data.
- Add editing and deleting entries.
- Add monthly insights/charts.
- Category icons and custom categories.
