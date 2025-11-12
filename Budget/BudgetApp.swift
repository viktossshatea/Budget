//
//  BudgetApp.swift
//  Budget
//
//  Created by  Виктория on 30.08.2025.
//

import SwiftUI
import SwiftData

@main
struct BudgetApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [
                    TransactionModel.self,
                    AppCurrency.self,
                    AppLocale.self,
                    AppLanguage.self
                ])
                .preferredColorScheme(.light)
                .environment(\.locale, Locale(identifier: viewModel.language))
                .environmentObject(viewModel)
        }
    }
}
