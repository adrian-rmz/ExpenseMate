//
//  TextAnalizer.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import NaturalLanguage

struct Expense {
    let type: String
    let amount: Double
    let category: String
}

func analyzeExpense(_ text: String) -> Expense? {
    var type: String? = nil
    var amount: Double? = nil
    var category: String? = nil
    
    // Words to ignore or use for context
    let ignoredWords = ["on", "from", "a", "as", "the", "of", "to", "at"]
    let incomeKeywords = ["received", "receive", "reciept", "got", "earned"]
    let expenseKeywords = ["spent", "pay", "paid", "used"]

    // Normalize input and split into words
    let words = text.lowercased().split(separator: " ").map { String($0) }

    for (index, word) in words.enumerated() {
        // Identify transaction type
        if expenseKeywords.contains(word) {
            type = "Expense"
        } else if incomeKeywords.contains(word) {
            type = "Income"
        }
        // Identify amount
        else if let value = Double(word.replacingOccurrences(of: "dot", with: ".")) {
            amount = value
        }
        // Identify category (first meaningful word after amount)
        else if !ignoredWords.contains(word), amount != nil, category == nil {
            category = word
        }
    }

    guard let type = type, let amount = amount, let category = category else {
        print("Error analyzing text: \(text)")
        return nil
    }
    return Expense(type: type, amount: amount, category: category)
}

func analyzeMultipleExpenses(_ text: String) -> [Expense] {
    let transactions = text.lowercased().split(separator: "and").map { String($0) }
    var expenses: [Expense] = []

    for transaction in transactions {
        if let expense = analyzeExpense(transaction) {
            expenses.append(expense)
        }
    }
    return expenses
}
