//
//  SettingsView.swift
//  Budget
//
//  Created by  Виктория on 06.09.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en"
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    @AppStorage("selectedLocale") var selectedLocale: String = "en_US"
    
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
                        selectedLanguage = "ru"
                    } label: {
                        Text("🇷🇺")
                            .font(.system(size: 40))
                    }
                    Button {
                        selectedLanguage = "en"
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
                        selectedCurrency = "RUB"
                        selectedLocale = "ru_RU"
                    } label: {
                        Text("₽")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "USD"
                        selectedLocale = "en_US_POSIX"
                    } label: {
                        Text("$")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "EUR"
                        selectedLocale = "en_IE"
                    } label: {
                        Text("€")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "AMD"
                        selectedLocale = "hy_AM"
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
