//
//  TransactionRow.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Text(transaction.category.capitalized)
            Spacer()
            Text("\(transaction.amount, specifier: "%.2f")")
                .foregroundColor(transaction.type == "Expense" ? .red : .green)
        }
    }
}

#Preview {
    TransactionRow(transaction: Transaction(type: "Expense", amount: 50.0, category: "Groceries"))
}

