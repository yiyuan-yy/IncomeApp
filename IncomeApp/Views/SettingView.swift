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
                Picker("Currency", selection: $incomeViewModel.currency) {
                    ForEach(Currency.allCases){currency in
                        Text(currency.rawValue + " " + currency.sign)
                    }
                }
                Picker("Time Filter", selection:  $incomeViewModel.filterType) {
                    ForEach(DateFilterType.allCases){type in
                        Text(type.name)
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


