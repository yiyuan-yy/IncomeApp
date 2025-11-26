//
//  SettingView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/24/25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var incomeViewModel: TransactionViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $incomeViewModel.sortDescending) {
                    Text("Sort \(incomeViewModel.sortDescending ? "↓" : "↑")")
                }
                Picker("Currency", selection: $incomeViewModel.currencyType) {
                    ForEach(Currency.allCases){currency in
                        Text(currency.rawValue + " " + currency.sign)
                    }
                }
                HStack {
                    Text("Minimum Filter")
                    TextField("Minimum Filter", value: $incomeViewModel.minimumFilter, format: .number.grouping(.automatic))
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}


