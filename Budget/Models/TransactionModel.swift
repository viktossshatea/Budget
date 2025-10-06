//
//  TransactionModel.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    var category: TransactionCategory
    var title: String
    var amount: Double
    var type: TransactionType
    var date: Date
    var currency: String
    
    var amountDisplay: String {
        let amountFormatter = NumberFormatter()
        amountFormatter.numberStyle = .currency
        amountFormatter.currencyCode = AppStorageCurrency.shared.currency
        amountFormatter.maximumFractionDigits = 2
        amountFormatter.locale = Locale(identifier: AppStorageLocale.shared.locale)
        return amountFormatter.string(from: amount as NSNumber) ?? "0.00"
    }

    var dateDisplay: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: AppStorageLocale.shared.locale)
        return formatter.string(from: date)
    }
}
