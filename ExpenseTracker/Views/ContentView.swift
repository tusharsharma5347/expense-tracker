import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ExpenseTrackerViewModel

    @State private var selectedType: EntryType = .withdrawal
    @State private var amountText: String = ""
    @State private var reasonText: String = ""
    @State private var selectedCategory: String = "Food"

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(.systemGray6), Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        summaryCard
                        addEntryCard
                        historySection
                    }
                    .padding()
                }
            }
            .navigationTitle("Expense Tracker")
        }
    }

    private var summaryCard: some View {
        VStack(spacing: 12) {
            Text("Balance")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(viewModel.balance, format: .currency(code: "USD"))
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(viewModel.balance >= 0 ? .green : .red)

            HStack {
                statBlock(title: "Deposit", value: viewModel.totalDeposits, color: .green)
                Divider()
                statBlock(title: "Withdrawal", value: viewModel.totalWithdrawals, color: .red)
            }
            .frame(height: 56)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var addEntryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Add Entry")
                .font(.headline)

            Picker("Type", selection: $selectedType) {
                ForEach(EntryType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)

            TextField("Amount", text: $amountText)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            TextField("Reason", text: $reasonText)
                .textFieldStyle(.roundedBorder)

            Picker("Category", selection: $selectedCategory) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(.menu)

            Button {
                viewModel.addEntry(
                    amountText: amountText,
                    reason: reasonText,
                    category: selectedCategory,
                    type: selectedType
                )
                amountText = ""
                reasonText = ""
            } label: {
                Text("Save")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var historySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Entries")
                .font(.headline)

            if viewModel.entries.isEmpty {
                Text("No entries yet")
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
            } else {
                ForEach(viewModel.entries) { entry in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.reason)
                                .font(.subheadline.weight(.semibold))
                            Text(entry.category)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text(entry.amount, format: .currency(code: "USD"))
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(entry.type == .deposit ? .green : .red)
                            Text(entry.date, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(12)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func statBlock(title: String, value: Double, color: Color) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value, format: .currency(code: "USD"))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
        .environmentObject(ExpenseTrackerViewModel())
}
