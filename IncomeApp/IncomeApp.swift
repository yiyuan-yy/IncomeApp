//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

@main
struct IncomeApp: App {
    @StateObject private var settings = SettingStore()
    @StateObject private var viewModel: TransactionViewModel
    
    init() {
        let s = SettingStore()
        _settings = StateObject(wrappedValue: s)
        _viewModel = StateObject(wrappedValue: TransactionViewModel(settings: s))
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(settings)
                .environmentObject(viewModel)
        }
    }
}
