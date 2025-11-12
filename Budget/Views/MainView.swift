//
//  MainView.swift
//  Budget
//
//  Created by  Виктория on 30.08.2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @Query var transactions: [TransactionModel]
    
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.main
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.1))
                                .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 30))
                                .frame(height: 250)
                            Spacer()
                        }
                        .shadow(color: Color.text.opacity(0.4), radius: 10, x: 0, y: 4)
                        .padding()
                        .padding(.top, 20)
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("balance")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.text)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 30)
                                        .padding(.top, 40)
                                    Text("\(viewModel.displayAmount(viewModel.countBalance(transactions)))")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.text)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, 30)
                                }
                                Spacer()
                            }
                            .padding()
                            Spacer()
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(Text("incomes")):")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.text)
                                    Text("\(viewModel.displayAmount(viewModel.countIncomes(transactions)))")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.text)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("\(Text("expenses")):")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.text)
                                    Text("\(viewModel.displayAmount(viewModel.countExpenses(transactions)))")
                                        .font(.system(size: 20))
                                        .foregroundStyle(.text)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 50)
                            Spacer()
                        }
                    }
                    .frame(height: 260)
                    
                    
                    ZStack {
                        if transactions.isEmpty {
                            VStack {
                                Text("addTransactions")
                                    .opacity(0.5)
                                    .padding(.top, 100)
                                Spacer()
                            }
                        }
                        List {
                            Section {
                                ForEach(viewModel.transactionsReversed ? Array(transactions.reversed()) : transactions) { transaction in
                                    Button {
                                        viewModel.transactionToEdit = transaction
                                        viewModel.showAddTransactionSheet = true
                                    } label: {
                                        HStack {
                                            switch transaction.type {
                                            case .income:
                                                Image(systemName: "chevron.up")
                                            case .expense:
                                                Image(systemName: "chevron.down")
                                            }
                                            Text(LocalizedStringKey(transaction.category.title))
                                            Spacer()
                                            Text(transaction.dateDisplay)
                                            Text(String(transaction.amountDisplay))
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, minHeight: 60)
                                        .glassEffect(.clear)
                                    }
                                    .buttonStyle(.plain)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                }
                                .onDelete { offsets in
                                    viewModel.delete(offsets: offsets, from: transactions, context: context)
                                }
                            } header: {
                                if !transactions.isEmpty {
                                    HStack {
                                        Button {
                                            viewModel.transactionsReversed.toggle()
                                        } label: {
                                            HStack {
                                                if viewModel.transactionsReversed == true {
                                                    Text("sort")
                                                    Image(systemName: "arrow.up")
                                                } else if viewModel.transactionsReversed == false {
                                                    Text("sort")
                                                    Image(systemName: "arrow.down")
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 10)
                                }
                            }
                        }
                        .shadow(color: Color.text.opacity(0.1), radius: 10, x: 0, y: 4)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.text)
                        
                        
                        VStack {
                            Spacer()
                                Button {
                                    viewModel.showAddTransactionSheet = true
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.clear)
                                            .frame(width: 100, height: 50)
                                            .glassEffect(.clear.tint(Color.white))
                                        Image(systemName: "plus")
                                            .foregroundStyle(Color.text)
                                    }
                                    .shadow(color: .text.opacity(0.4), radius: 10, x: 0, y: 4)
                                }
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.showSettingsSheet = true
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.clear)
                                            .frame(width: 50, height: 50)
                                            .glassEffect(.clear.tint(Color.white))
                                        Image(systemName: "gearshape.fill")
                                            .foregroundStyle(Color.text)
                                    }
                                    .padding(.trailing)
                                    .shadow(color: .text.opacity(0.4), radius: 10, x: 0, y: 4)
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddTransactionSheet) {
            AddTransactionView(isPresented: $viewModel.showAddTransactionSheet, transactionToEdit: $viewModel.transactionToEdit)
        }
        .sheet(isPresented: $viewModel.showSettingsSheet) {
            SettingsView()
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    MainView()
        .environment(\.locale, .init(identifier: "en"))
}
