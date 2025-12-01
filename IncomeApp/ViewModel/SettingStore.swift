//
//  SettingStore.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//
import Foundation

final class SettingStore: ObservableObject {
    private let defaults = UserDefaults.standard

    @Published var dateFilter: DateFilterType {
        didSet { defaults.set(dateFilter.rawValue, forKey: "dateFilter") }
    }
    @Published var minimumFilter: Double {
        didSet { defaults.set(minimumFilter, forKey: "minimumFilter") }
    }
    @Published var sortDescending: Bool {
        didSet { defaults.set(sortDescending, forKey: "sortDescending") }
    }
    @Published var currencyType: CurrencyType {
        didSet { defaults.set(currencyType.rawValue, forKey: "currency") }
    }

    init() {
        dateFilter = DateFilterType(rawValue: defaults.integer(forKey: "dateFilter")) ?? .thisMonth
        minimumFilter = defaults.double(forKey: "minimumFilter")
        sortDescending = defaults.bool(forKey: "sortDescending")
        currencyType = CurrencyType(rawValue: defaults.integer(forKey: "currency")) ?? .CNY
    }
}
