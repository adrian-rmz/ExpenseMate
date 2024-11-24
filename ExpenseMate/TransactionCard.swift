//
//  TransactionCard.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct TransactionCard: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(transaction.category.capitalized)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(transaction.amount, specifier: "%.2f")")
                .font(.title3)
                .bold()
                .foregroundColor(transaction.type == "Expense" ? .red : .green)
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    TransactionCard(transaction: Transaction(type: "Expense", amount: 50, category: "Groceries"))
}
