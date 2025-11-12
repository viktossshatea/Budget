//
//  ViewModel.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import Foundation
import SwiftUI
import SwiftData

class ViewModel: ObservableObject {
    @Published var showAddTransactionSheet = false
    @Published var showSettingsSheet = false
    @Published var transactionToEdit : TransactionModel?
    @Published var transactionsReversed: Bool = true
    @Published var language = AppLanguage().code
    @Published var currency = AppCurrency().code
    @Published var locale = AppLocale().code
    
    func countIncomes(_ transactions: [TransactionModel]) -> Double {
        var incomesSumm = 0.0
        for transaction in transactions {
            if transaction.type == .income {
                incomesSumm += transaction.amount
            }
        }
        return incomesSumm
    }
    
    func countExpenses(_ transactions: [TransactionModel]) -> Double {
        var ExpensesSumm = 0.0
        for transaction in transactions {
            if transaction.type == .expense {
                ExpensesSumm += transaction.amount
            }
        }
        return ExpensesSumm
    }
    
    func countBalance(_ transactions: [TransactionModel]) -> Double {
        var balance = 0.0
        for transaction in transactions {
            if transaction.type == .income {
                balance += transaction.amount
            } else {
                balance -= transaction.amount
            }
        }
        return balance
    }
    
    func displayAmount(_ amount: Double) -> String {
        let amountFormatter = NumberFormatter()
        amountFormatter.numberStyle = .currency
        amountFormatter.currencyCode = currency
        amountFormatter.maximumFractionDigits = 2
        amountFormatter.locale = Locale(identifier: locale)
        return amountFormatter.string(from: amount as NSNumber) ?? "0.00"
    }

    func delete(offsets: IndexSet, from: [TransactionModel], context: ModelContext) {
        for index in offsets {
            let transactionToDelete = from[index]
            context.delete(transactionToDelete)
            try? context.save()
        }
    }
    
    func currency(_ currency: String) -> String {
        switch currency {
        case "USD":
            return "$"
        case "RUB":
            return "₽"
        case "AMD":
            return "֏"
        case "EUR":
            return "€"
        default:
            return "$"
        }
    }
}
