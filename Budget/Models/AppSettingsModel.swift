//
//  CurrencyModel.swift
//  Budget
//
//  Created by  Виктория on 07.09.2025.
//

import SwiftUI
import SwiftData

@Model class AppLanguage {
    var language: String
    
    init(language: String = "en_US_POSTIX") {
        self.language = language
    }
    
    var code: String {
        return language
    }
}

@Model class AppCurrency {
    var currency: String
    
    init(currency: String = "USD") {
        self.currency = currency
    }
    
    var code: String {
        return currency
    }
}

@Model class AppLocale {
    var locale: String
    
    init(locale: String = "en_US") {
        self.locale = locale
    }
    
    var code: String {
        return locale
    }
}
