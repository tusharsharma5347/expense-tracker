import Foundation

enum EntryType: String, CaseIterable, Identifiable {
    case deposit = "Deposit"
    case withdrawal = "Withdrawal"

    var id: String { rawValue }
}

struct Transaction: Identifiable {
    let id = UUID()
    let amount: Double
    let reason: String
    let category: String
    let type: EntryType
    let date: Date
}
