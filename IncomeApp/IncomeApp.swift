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
    @StateObject private var viewModel = TransactionViewModel(settings: SettingStore())
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(settings)
                .environmentObject(viewModel)
        }
    }
}
