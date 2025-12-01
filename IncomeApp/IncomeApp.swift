//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

@main
struct IncomeApp: App {
    @StateObject var settings: SettingStore = SettingStore()
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel(settings: settings)
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
