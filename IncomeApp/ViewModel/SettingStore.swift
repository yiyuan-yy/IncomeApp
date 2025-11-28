//
//  SettingStore.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//
import Foundation
import SwiftUI


final class SettingStore: ObservableObject {
    // MARK: - settings
    // filtered transactions by date and minimum filter
    @AppStorage("dateFilter") var dateFilter: DateFilterType = .thisMonth  // time filter
    @AppStorage("minimumFilter") var minimumFilter: Double = 0.0     // minimum filter
    // sort order
    @AppStorage("sortDescending") var sortDescending = true
    // currency
    @AppStorage("currency") var currencyType: CurrencyType = .CNY
}
