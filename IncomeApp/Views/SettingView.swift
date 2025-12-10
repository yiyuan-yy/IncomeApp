//
//  SettingView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/24/25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var settings: SettingStore
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $settings.sortDescending) {
                    Text("Sort \(settings.sortDescending ? "↓" : "↑")")
                }
                Picker("Currency", selection: $settings.currencyType) {
                    ForEach(CurrencyType.allCases){currency in
                        Text(currency.title + " " + currency.sign)
                    }
                }
                HStack {
                    Text("Minimum Filter")
                    TextField("Minimum Filter", value: $settings.minimumFilter, format: .number.grouping(.automatic))
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}


