//
//  ContentView.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var expenseManager = ExpenseManager()
    @State private var isRecording = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    // Summary Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            SummaryCard(
                                title: "Income",
                                amount: calculateTotal(type: "Income"),
                                color: .green
                            )
                            SummaryCard(
                                title: "Expenses",
                                amount: calculateTotal(type: "Expense"),
                                color: .red
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)

                    // Transactions Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Transactions")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        VStack(spacing: 10) {
                            ForEach(expenseManager.transactions) { transaction in
                                TransactionCard(transaction: transaction)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }

                // Fixed Voice Input Section
                HStack(spacing: 10) {
                    Text(speechRecognizer.transcribedText.isEmpty ? "Speak your transaction..." : speechRecognizer.transcribedText)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)

                    Button(action: {
                        if isRecording {
                            speechRecognizer.stopRecording()
                            let transactions = analyzeExpenses(speechRecognizer.transcribedText)
                            for transaction in transactions {
                                expenseManager.addTransaction(expense: transaction)
                            }
                        } else {
                            speechRecognizer.startRecording()
                        }
                        isRecording.toggle()
                    }) {
                        Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(isRecording ? .red : .blue)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground).shadow(radius: 5))
            }
            .navigationTitle("ExpenseMate")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ChartsView(transactions: expenseManager.transactions)) {
                        Image(systemName: "chart.pie.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    private func calculateTotal(type: String) -> Double {
        return expenseManager.transactions
            .filter { $0.type == type }
            .map { $0.amount }
            .reduce(0, +)
    }
}

#Preview {
    ContentView()
}
