//
//  ExpenseManager.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let type: String
    let amount: Double
    let category: String
    let date: Date
}

class ExpenseManager: ObservableObject {
    @Published var transactions: [Transaction] = []

    func addTransaction(expense: Expense) {
        let transaction = Transaction(type: expense.type,
                                      amount: expense.amount,
                                      category: expense.category,
                                      date: Date())
        transactions.append(transaction)
    }
}
