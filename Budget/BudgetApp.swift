//
//  BudgetApp.swift
//  Budget
//
//  Created by  Виктория on 30.08.2025.
//

import SwiftUI

@main
struct BudgetApp: App {
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en"
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    @AppStorage("selectedLocale") var selectedLocale: String = "en_US"
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
                .environment(\.locale, Locale(identifier: selectedLanguage))
        }
    }
}
