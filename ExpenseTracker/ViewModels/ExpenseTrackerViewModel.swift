import Foundation
import Combine

final class ExpenseTrackerViewModel: ObservableObject {
    @Published var entries: [Transaction] = []

    let categories = [
        "Food",
        "Transport",
        "Bills",
        "Shopping",
        "Salary",
        "Misc"
    ]

    var totalDeposits: Double {
        entries
            .filter { $0.type == .deposit }
            .reduce(0) { $0 + $1.amount }
    }

    var totalWithdrawals: Double {
        entries
            .filter { $0.type == .withdrawal }
            .reduce(0) { $0 + $1.amount }
    }

    var balance: Double {
        totalDeposits - totalWithdrawals
    }

    func addEntry(amountText: String, reason: String, category: String, type: EntryType) {
        guard let amount = Double(amountText), amount > 0 else { return }

        let cleanReason = reason.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanReason.isEmpty else { return }

        let newEntry = Transaction(
            amount: amount,
            reason: cleanReason,
            category: category,
            type: type,
            date: Date()
        )

        entries.insert(newEntry, at: 0)
    }
}
