//
//  ContentView.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = MainScreenViewModel()
    var body: some View {
        NavigationStack {
            List {
                Section("General") {
                    HStack {
                        Text("Address:")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Spacer()
                        Text(viewModel.walletDetails?.address ?? "")
                            .font(.system(size: 12))
                            .lineLimit(1)
                        if let _ = viewModel.walletDetails?.address {
                            TextCopyButton(text: viewModel.walletDetails?.address ?? "")
                        }
                    }
                    HStack {
                        Text("Balance:")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Spacer()
                        if let unwrappedBalance = viewModel.walletDetails?.cryptoDetails?.balance {
                            Group {
                                Text(String(unwrappedBalance)) +
                                Text(" ETH").fontWeight(.bold)
                            }
                            .font(.system(size: 12))
                            .lineLimit(1)

                            TextCopyButton(text: String(unwrappedBalance))
                        }
                    }
                }

                Group {
                    if let tokens = viewModel.walletDetails?.tokens?.prefix(5) {
                        Section("NFT Lookup (max 5)") {
                            NFTLookupView(tokens: Array(tokens))
                        }
                    }
                }

                Group {
                    if let lastTransactions = viewModel.lastTransactions {
                        Section("Last transactions (max 5)") {
                            LastTransactionsGrid(transactions: lastTransactions)
                        }
                    }
                }
                .navigationTitle("Wallet Details")
            }
        }
        .onAppear(perform: {
            DatabaseService.shared.fetch { dto, erros in
                if let dto = dto?.first?.toDomain() {
                    viewModel.walletDetails = dto
                }
            }
        })
        .searchable(text: $viewModel.publicWalletAddress, prompt: "Paste public ETH Address here")
        .onSubmit(of: .search, viewModel.fetchWalletDetails)
    }
}
