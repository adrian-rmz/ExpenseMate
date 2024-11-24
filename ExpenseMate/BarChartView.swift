//
//  BarChartView.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI
import Charts

struct BarChartView: View {
    let transactions: [Transaction]

    var body: some View {
        Chart {
            BarMark(
                x: .value("Type", "Income"),
                y: .value("Total", totalAmount(type: "Income"))
            )
            .foregroundStyle(.green)

            BarMark(
                x: .value("Type", "Expense"),
                y: .value("Total", totalAmount(type: "Expense"))
            )
            .foregroundStyle(.red)
        }
        .frame(height: 200)
        .padding()
    }

    private func totalAmount(type: String) -> Double {
        return transactions
            .filter { $0.type == type }
            .map { $0.amount }
            .reduce(0, +)
    }
}


#Preview {
    BarChartView(transactions: [
        Transaction(type: "Income", amount: 1000, category: "Salary"),
        Transaction(type: "Expense", amount: 500, category: "Rent"),
        Transaction(type: "Expense", amount: 200, category: "Utilities")
    ])
}

