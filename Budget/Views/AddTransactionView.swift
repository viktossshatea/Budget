//
//  AddTransactionView.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import SwiftUI

struct AddTransactionView: View {
    @StateObject var viewModel = ViewModel()
    @State var amount = ""
    @State var descriptipon = ""
    @State var selectedTransactionType: TransactionType = .income
    @State var selectedTransactionCategory: TransactionCategory = .salary
    @Binding var isPresented : Bool
    @Binding var transactions: [Transaction]
    @Binding var transactionToEdit: Transaction?
    @FocusState private var isFocusedAmount: Bool
    
    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()
            VStack {
                TextField("\(viewModel.currency(viewModel.selectedCurrency))0.00", text: $amount)
                    .onChange(of: amount) { _, newAmount in
                        amount = newAmount.replacingOccurrences(of: ",", with: ".")
                    }
                    .font(.system(size:100, weight: .thin))
                    .foregroundStyle(.text)
                    .frame(maxHeight: 40)
                    .focused($isFocusedAmount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                
                HStack {
                    Picker("Choose Transaction Type", selection: $selectedTransactionType) {
                        ForEach(TransactionType.allCases) { transactionType in
                            Text(LocalizedStringKey(transactionType.title))
                                .tag(transactionType)
                        }
                    }
                    .pickerStyle(.menu)
                    .glassEffect(.clear)
                    .clipShape(Capsule())
                    .padding(35)
                    
                    Picker("Choose Transaction Category", selection: $selectedTransactionCategory) {
                        ForEach(TransactionCategory.allCases) { transactionCategory in
                            Text(LocalizedStringKey(transactionCategory.title))
                                .font(.title)
                                .tag(transactionCategory)
                        }
                    }
                    .pickerStyle(.menu)
                    .glassEffect(.clear)
                    .clipShape(Capsule())
                    .padding(35)
                }
                .padding(.vertical, 30)
                
                TextField("Description...", text: $descriptipon)
                    .textFieldStyle(.plain)
                    .padding()
                    .frame(minHeight: 50)
                    .foregroundStyle(.text)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.clear)
                            .glassEffect(.clear)
                    )
                    .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    VStack {
                        Spacer()
                        Button {
                            let transaction = Transaction(category: selectedTransactionCategory, title: descriptipon, amount: Double(amount) ?? 0.00, type: selectedTransactionType, date: Date(), currency: viewModel.selectedCurrency)
                            
                            if transactionToEdit  != nil {
                                if let index = transactions.firstIndex(of: transactionToEdit!) {
                                    transactions[index] = transaction
                                }
                            } else {
                                transactions.append(transaction)
                            }
                            isPresented = false
                            transactionToEdit = nil
                            
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 200, height: 50)
                                    .glassEffect(.clear.tint(Color.white))
                                Text(transactionToEdit == nil ? "addTransaction" : "updateTransaction")
                                    .foregroundStyle(Color.text)
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if transactionToEdit != nil {
                                Button {
                                    transactions.removeAll { $0 == transactionToEdit! }
                                    isPresented = false
                                    transactionToEdit = nil
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.clear)
                                            .frame(width: 50, height: 50)
                                            .glassEffect(.clear.tint(Color.white))
                                        Image(systemName: "trash")
                                            .foregroundStyle(Color.text)
                                    }
                                    .padding(.trailing)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                if transactionToEdit != nil {
                    amount = String(transactionToEdit!.amount)
                    selectedTransactionType = transactionToEdit!.type
                    selectedTransactionCategory = transactionToEdit!.category
                    descriptipon = transactionToEdit!.title
                }
            }
            
            if isFocusedAmount {
                VStack {
                    Spacer()
                    Button {
                        isFocusedAmount = false
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10))
                    }
                    .buttonStyle(.glass(.clear))
                }
                .padding(.bottom, 60)
            }
        }
    }
}
#Preview {
    AddTransactionView(isPresented: .constant(true), transactions: .constant([]), transactionToEdit: .constant(Transaction(category: .shopping, title: "Shopping", amount: 22.5, type: .expense, date: Date(), currency: "USD")))
        .environment(\.locale, .init(identifier: "en"))
}
