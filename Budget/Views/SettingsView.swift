//
//  SettingsView.swift
//  Budget
//
//  Created by  Виктория on 06.09.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
        var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("\(Text("changeLanguage")):")
                    .foregroundStyle(.text)
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing: 30) {
                    Button {
                        viewModel.language = AppLanguage(language: "ru_RU").code
                    } label: {
                        Text("🇷🇺")
                            .font(.system(size: 40))
                    }
                    Button {
                        viewModel.language = AppLanguage(language: "en_US").code
                    } label: {
                        Text("🇺🇸")
                            .font(.system(size: 40))
                    }
                }
                Text("\(Text("changeCurrency")):")
                    .foregroundStyle(.text)
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing: 30) {
                    Button {
                        viewModel.currency = AppCurrency(currency: "RUB").code
                        viewModel.locale = AppLocale(locale: "ru_RU").code
                    } label: {
                        Text("₽")
                            .font(.system(size: 30))
                    }
                    Button {
                        viewModel.currency = AppCurrency(currency: "USD").code
                        viewModel.locale = AppLocale(locale: "en_US_POSTIX").code
                    } label: {
                        Text("$")
                            .font(.system(size: 30))
                    }
                    Button {
                        viewModel.currency = AppCurrency(currency: "EUR").code
                        viewModel.locale = AppLocale(locale: "en_IE").code
                    } label: {
                        Text("€")
                            .font(.system(size: 30))
                    }
                    Button {
                        viewModel.currency = AppCurrency(currency: "AMD").code
                        viewModel.locale = AppLocale(locale: "hy_AM").code
                    } label: {
                        Text("֏")
                            .font(.system(size: 30))
                    }
                }
                Spacer()
            }
            .padding(.top, 30)
        }
    }
}

#Preview {
    SettingsView()
}
