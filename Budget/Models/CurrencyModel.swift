//
//  CurrencyModel.swift
//  Budget
//
//  Created by  Виктория on 07.09.2025.
//

import SwiftUI

class AppStorageCurrency {
    static let shared = AppStorageCurrency()       // Единственный экземпляр
    @AppStorage("selectedCurrency") var currency: String = "USD"  // Валюта из настроек
    private init() {}
}
