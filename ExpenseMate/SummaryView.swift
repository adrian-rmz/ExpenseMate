//
//  SummaryView.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct SummaryView: View {
    let income: Double
    let expense: Double

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Income")
                        .font(.headline)
                    Text("\(income, specifier: "%.2f")")
                        .foregroundColor(.green)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Expense")
                        .font(.headline)
                    Text("\(expense, specifier: "%.2f")")
                        .foregroundColor(.red)
                }
            }
            .padding()

            HStack {
                Text("Balance")
                    .font(.title2)
                Spacer()
                Text("\(income - expense, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor((income - expense) >= 0 ? .green : .red)
            }
            .padding()
        }
    }
}


#Preview {
    SummaryView(income: 22, expense: 37)
}
