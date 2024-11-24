//
//  PieChartView.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
    let transactions: [Transaction]

    var body: some View {
        Chart {
            ForEach(groupByCategory(transactions), id: \.0) { category, total in
                SectorMark(
                    angle: .value("Amount", total),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(1.0)
                )
                .foregroundStyle(by: .value("Category", category))
            }
        }
        .frame(height: 200)
        .padding()
    }

    // Helper to group transactions by category and return as an array
    private func groupByCategory(_ transactions: [Transaction]) -> [(String, Double)] {
        var categoryTotals: [String: Double] = [:]
        for transaction in transactions where transaction.type == "Expense" {
            categoryTotals[transaction.category, default: 0] += transaction.amount
        }
        return categoryTotals.sorted { $0.key < $1.key } // Convert to sorted array
    }
}



#Preview {
    PieChartView(transactions: [
        Transaction(type: "Expense", amount: 50, category: "Groceries"),
        Transaction(type: "Expense", amount: 30, category: "Coffee"),
        Transaction(type: "Expense", amount: 20, category: "Transport")
    ])
}

