//
//  ViewModel.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    @Published var transactions : [Transaction] = [
        Transaction(category: .shopping, title: "Shopping", amount: 22.5, type: .expense, date: Date(), currency: "USD"),
        Transaction(category: .salary, title: "TgPrems", amount: 425, type: .income, date: Date(), currency: "USD"),
        Transaction(category: .shopping, title: "Camera", amount: 300, type: .expense, date: Date(), currency: "USD"),
        Transaction(category: .shopping, title: "Shopping", amount: 22.5, type: .expense, date: Date(), currency: "USD"),
        Transaction(category: .salary, title: "Donation", amount: 30, type: .income, date: Date(), currency: "USD"),
        Transaction(category: .cafe, title: "Coffee", amount: 4.5, type: .expense, date: Date(), currency: "USD")
    ]
    @Published var showAddTransactionSheet = false
    @Published var showSettingsSheet = false
    @Published var transactionToEdit : Transaction?
    @Published var transactionsReversed: Bool = true
    
    func countIncomes(_ transactions: [Transaction]) -> Double {
        var incomesSumm = 0.0
        for transaction in transactions {
            if transaction.type == .income {
                incomesSumm += transaction.amount
            }
        }
        return incomesSumm
    }
    
    func countExpenses(_ transactions: [Transaction]) -> Double {
        var ExpensesSumm = 0.0
        for transaction in transactions {
            if transaction.type == .expense {
                ExpensesSumm += transaction.amount
            }
        }
        return ExpensesSumm
    }
    
    func countBalance(_ transactions: [Transaction]) -> Double {
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
        amountFormatter.currencyCode = AppStorageCurrency.shared.currency
        amountFormatter.maximumFractionDigits = 2
        amountFormatter.locale = Locale(identifier: AppStorageLocale.shared.locale)
        return amountFormatter.string(from: amount as NSNumber) ?? "0.00"
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
