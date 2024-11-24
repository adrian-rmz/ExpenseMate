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
                List {
                    ForEach(expenseManager.transactions) { transaction in
                        HStack {
                            Text(transaction.category.capitalized)
                            Spacer()
                            Text(String(format: "%.2f", transaction.amount))
                                .foregroundColor(transaction.type == "Expense" ? .red : .green)
                        }
                    }
                }

                Spacer()

                Text(speechRecognizer.transcribedText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Button(action: {
                    if isRecording {
                        speechRecognizer.stopRecording()
                        let transactions = analyzeExpenses(speechRecognizer.transcribedText)
                        for expense in transactions {
                            expenseManager.addTransaction(expense: expense)
                        }
                    } else {
                        speechRecognizer.startRecording()
                    }
                    isRecording.toggle()
                }) {
                    Text(isRecording ? "Stop Recording" : "Start Recording")
                        .padding()
                        .background(isRecording ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("VoiceExpense")
        }
    }
}

#Preview {
    ContentView()
}
