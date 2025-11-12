//
//  TransactionCategory.swift
//  Budget
//
//  Created by  Виктория on 31.08.2025.
//

import Foundation

enum TransactionCategory: String, Identifiable, CaseIterable, Codable {
    case shopping
    case groccery
    case cafe
    case rent
    case transport
    case subscription
    case gifts
    case education
    case health
    case salary
    
    var id: Self { self }
    
    var title : String {
        switch self {
        case .shopping:
            return "shopping"
        case .groccery:
            return "groccery"
        case .cafe:
            return "cafe"
        case .rent:
            return "rent"
        case .transport:
            return "transport"
        case .subscription:
            return "subscription"
        case .gifts:
            return "gifts"
        case .education:
            return "education"
        case .health:
            return "health"
        case .salary:
            return "salary"
        }
    }
}
