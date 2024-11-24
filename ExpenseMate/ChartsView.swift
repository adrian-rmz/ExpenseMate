//
//  ChartsView.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct ChartsView: View {
    let transactions: [Transaction]

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 16) {
                Text("Expenses by Category")
                    .font(.headline)
                PieChartView(transactions: transactions)

                Text("Income vs Expense")
                    .font(.headline)
                BarChartView(transactions: transactions)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Expense Analytics")
    }
}

#Preview {
    ChartsView(transactions: [
        Transaction(type: "Expense", amount: 50, category: "Groceries"),
        Transaction(type: "Income", amount: 1000, category: "Salary"),
        Transaction(type: "Expense", amount: 20, category: "Coffee")
    ])
}

