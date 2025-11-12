//
//  TransactionType.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

enum TransactionType : String, CaseIterable, Identifiable, Codable {
    case income
    case expense
    
    var id: Self { self }
    
    var title : String {
        switch self {
        case .income:
            return "incomes"
        case .expense:
            return "expenses"
        }
    }
}
