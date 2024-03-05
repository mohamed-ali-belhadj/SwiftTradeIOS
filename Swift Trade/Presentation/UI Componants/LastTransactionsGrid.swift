//
//  LastTransactionsGrid.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import SwiftUI

struct LastTransactionsGrid: View {
    var transactions: [SingleTransactionEntity]

    init(transactions: [SingleTransactionEntity]) {
        self.transactions = transactions
    }

    var body: some View {
        VStack {
            Grid {
                GridRow {
                    Text("From")
                    Text("To")
                    Text("Value") + Text("  ETH").font(.system(size: 8))
                }
                .font(.caption)
                .bold()
                Divider()
                ForEach(transactions) { singleTransaction in
                    GridRow {
                        HStack {
                            Text(singleTransaction.from ?? "N/A")
                                .lineLimit(1)
                        }
                        Text(singleTransaction.to ?? "N/A")
                            .lineLimit(1)
                        Text(String(singleTransaction.value ?? 0))
                    }
                    .font(.system(size: 14))
                    if singleTransaction != transactions.last {
                        Divider()
                    }
                }
            }
        }
        .frame(maxHeight: 400)
    }
}
