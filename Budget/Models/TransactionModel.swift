//
//  TransactionModel.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model class TransactionModel {
    var id = UUID()
    var category: TransactionCategory
    var title: String
    var amount: Double
    var type: TransactionType
    var date: Date
    var currency: String
    var locale: String
    
    init(category: TransactionCategory, title: String, amount: Double, type: TransactionType, date: Date, currency: String, locale: String) {
        self.id = UUID()
        self.category = category
        self.title = title
        self.amount = amount
        self.type = type
        self.date = date
        self.currency = currency
        self.locale = locale
    }
    
    var amountDisplay: String {
        let amountFormatter = NumberFormatter()
        amountFormatter.numberStyle = .currency
        amountFormatter.currencyCode = currency
        amountFormatter.maximumFractionDigits = 2
        amountFormatter.locale = Locale(identifier: locale)
        return amountFormatter.string(from: amount as NSNumber) ?? "0.00"
    }

    var dateDisplay: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: date)
    }
}
