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
                    } label: {
                        Text("₽")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "USD"
                    } label: {
                        Text("$")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "EUR"
                    } label: {
                        Text("€")
                            .font(.system(size: 30))
                    }
                    Button {
                        selectedCurrency = "AMD"
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
