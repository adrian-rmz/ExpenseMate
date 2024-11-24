//
//  SummaryCard.swift
//  ExpenseMate
//
//  Created by Adrián Alejandro Ramírez Cruz on 24/11/24.
//

import SwiftUI

struct SummaryCard: View {
    let title: String
    let amount: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text("\(amount, specifier: "%.2f")")
                .font(.title)
                .bold()
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(color)
        .cornerRadius(15)
    }
}

#Preview {
    SummaryCard(title: "Income", amount: 1500, color: .green)
}

