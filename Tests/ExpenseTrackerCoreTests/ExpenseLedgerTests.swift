import XCTest
@testable import ExpenseTrackerCore

final class ExpenseLedgerTests: XCTestCase {
    func testAddDepositAndWithdrawalUpdatesTotals() {
        var ledger = ExpenseLedger()

        XCTAssertTrue(ledger.addEntry(amountText: "1200", reason: "Salary", category: "Salary", type: .deposit))
        XCTAssertTrue(ledger.addEntry(amountText: "200", reason: "Groceries", category: "Food", type: .withdrawal))

        XCTAssertEqual(ledger.totalDeposits, 1200)
        XCTAssertEqual(ledger.totalWithdrawals, 200)
        XCTAssertEqual(ledger.balance, 1000)
        XCTAssertEqual(ledger.entries.count, 2)
    }

    func testInvalidEntryIsRejected() {
        var ledger = ExpenseLedger()

        XCTAssertFalse(ledger.addEntry(amountText: "0", reason: "", category: "Misc", type: .withdrawal))
        XCTAssertFalse(ledger.addEntry(amountText: "abc", reason: "Taxi", category: "Transport", type: .withdrawal))

        XCTAssertEqual(ledger.entries.count, 0)
        XCTAssertEqual(ledger.balance, 0)
    }
}
