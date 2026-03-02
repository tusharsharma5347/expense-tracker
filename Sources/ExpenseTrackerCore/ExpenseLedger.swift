import Foundation

public enum EntryType: String, CaseIterable, Identifiable, Codable, Sendable {
    case deposit = "Deposit"
    case withdrawal = "Withdrawal"

    public var id: String { rawValue }
}

public struct Transaction: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let amount: Double
    public let reason: String
    public let category: String
    public let type: EntryType
    public let date: Date

    public init(
        id: UUID = UUID(),
        amount: Double,
        reason: String,
        category: String,
        type: EntryType,
        date: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.reason = reason
        self.category = category
        self.type = type
        self.date = date
    }
}

public struct ExpenseLedger: Sendable {
    public private(set) var entries: [Transaction]

    public init(entries: [Transaction] = []) {
        self.entries = entries
    }

    public var totalDeposits: Double {
        entries
            .filter { $0.type == .deposit }
            .reduce(0) { $0 + $1.amount }
    }

    public var totalWithdrawals: Double {
        entries
            .filter { $0.type == .withdrawal }
            .reduce(0) { $0 + $1.amount }
    }

    public var balance: Double {
        totalDeposits - totalWithdrawals
    }

    @discardableResult
    public mutating func addEntry(amountText: String, reason: String, category: String, type: EntryType) -> Bool {
        guard let amount = Double(amountText), amount > 0 else { return false }

        let cleanReason = reason.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanReason.isEmpty else { return false }

        entries.insert(
            Transaction(
                amount: amount,
                reason: cleanReason,
                category: category,
                type: type
            ),
            at: 0
        )
        return true
    }
}
