//
//  AddTransactionView.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.modelContext) var context
    @State private var amount = ""
    @State private var title = ""
    @State private var selectedTransactionType: TransactionType = .income
    @State private var selectedTransactionCategory: TransactionCategory = .salary
    @State private var day: Int = Calendar.current.component(.day, from: Date())
    @State private var month: Int = Calendar.current.component(.month, from: Date())
    @Binding var isPresented : Bool
    @Binding var transactionToEdit: TransactionModel?
    @FocusState var isFocusedAmount: Bool
    
    
    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()
            VStack {
                TextField("\(viewModel.currency(viewModel.currency))0.00", text: $amount)
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
                
                HStack {
                    Text("date")
                    Spacer()
                    Text("month")
                }
                .padding(.horizontal, 75)
                
                HStack {
                    Picker("date", selection: $day) {
                        ForEach(1...31, id: \.self) {
                            Text("\($0)")
                                .font(.title)
                        }
                    }
                    .pickerStyle(.wheel)
                    .glassEffect(.clear)
                    .clipShape(Capsule())
                    .padding(.horizontal, 60)
                    
                    Picker("month", selection: $month) {
                        ForEach(1...12, id: \.self) {
                            Text("\($0)")
                                .font(.title)
                        }
                    }
                    .pickerStyle(.wheel)
                    .glassEffect(.clear)
                    .clipShape(Capsule())
                    .padding(.horizontal, 60)
                }
                .padding(.bottom, 30)
                
            
                TextField("Description...", text: $title)
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
                    .padding(.top, 30)
                
                Spacer()
                
                ZStack {
                    VStack {
                        Spacer()
                        Button {
                            let year = Calendar.current.component(.year, from: Date())
                            var comps = DateComponents()
                            comps.year = year
                            comps.month = month
                            comps.day = day
                            let pickedDate = Calendar.current.date(from: comps) ?? Date()
                            
                            if let existingTransaction = transactionToEdit {
                                existingTransaction.title = title
                                existingTransaction.amount = Double(amount) ?? 0.00
                                existingTransaction.category = selectedTransactionCategory
                                existingTransaction.type = selectedTransactionType
                            } else {
                                let transaction = TransactionModel(category: selectedTransactionCategory, title: title, amount: Double(amount) ?? 0.00, type: selectedTransactionType, date: pickedDate, currency: viewModel.currency, locale: viewModel.locale)
                                context.insert(transaction)
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
                }
            }
            .onAppear {
                if transactionToEdit != nil {
                    amount = String(transactionToEdit!.amount)
                    selectedTransactionType = transactionToEdit!.type
                    selectedTransactionCategory = transactionToEdit!.category
                    title = transactionToEdit!.title
                    let calendar = Calendar.current
                    day = calendar.component(.day, from: transactionToEdit!.date)
                            month = calendar.component(.month, from: transactionToEdit!.date)
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
    AddTransactionView(isPresented: .constant(true), transactionToEdit: .constant(TransactionModel(category: .groccery, title: "Grocery shopping", amount: 25, type: .expense, date: Date(), currency: "USD", locale: "en_US")))
        .environment(\.locale, Locale(identifier: "en_US"))
}
