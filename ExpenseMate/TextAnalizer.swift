//
//  TextAnalyzer.swift
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

func analyzeExpenses(_ text: String) -> [Expense] {
    var expenses: [Expense] = []
    var lastType: String? = nil // Keep track of the last detected transaction type

    // Words to ignore or use for context
    let ignoredWords = ["on", "from", "a", "as", "the", "of", "to", "at"]
    let incomeKeywords = ["received", "receive", "got", "earned"]
    let expenseKeywords = ["spent", "pay", "paid", "used"]

    // Normalize text and split by "and" to handle potential multiple transactions
    let segments = text.lowercased().split(separator: "and").map { String($0) }

    for segment in segments {
        var type: String? = nil
        var amount: Double? = nil
        var category: String? = nil

        // Tokenize the segment
        let words = segment.split(separator: " ").map { String($0) }

        for word in words {
            // Identify transaction type within each segment
            if expenseKeywords.contains(word) {
                type = "Expense"
            } else if incomeKeywords.contains(word) {
                type = "Income"
            }
            // Identify amount
            if let value = Double(word.replacingOccurrences(of: "dot", with: ".")) {
                amount = value
            }
            // Identify category
            else if !ignoredWords.contains(word), amount != nil, category == nil {
                category = word
            }
        }

        // Use the last detected type if none is explicitly set
        type = type ?? lastType

        // Update the lastType for subsequent segments
        if let detectedType = type {
            lastType = detectedType
        }

        // If a valid transaction is found, append it to the list
        if let type = type, let amount = amount, let category = category {
            expenses.append(Expense(type: type, amount: amount, category: category))
        }
    }

    return expenses
}

