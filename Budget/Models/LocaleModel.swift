//
//  CurrencyModel.swift
//  Budget
//
//  Created by  Виктория on 07.09.2025.
//

import SwiftUI

class AppStorageCurrency {
    static let shared = AppStorageCurrency()
    @AppStorage("selectedCurrency") var currency: String = "USD"
    private init() {}
}

class AppStorageLocale {
    static let shared = AppStorageLocale()
    @AppStorage("selectedLocale") var locale: String = "en_US"
    private init() {}
}
