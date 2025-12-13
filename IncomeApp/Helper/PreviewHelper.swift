//
//  PreviewHelper.swift
//  IncomeApp
//
//  Created by yiyuan hu on 12/13/25.
//

import Foundation
import SwiftData

@MainActor
class PreviewHelper {
    static let previewContainer: ModelContainer  = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: Transaction.self, configurations: config)
            for transaction in PreviewHelper.example {
                container.mainContext.insert(transaction)
            }
            return container
        } catch {
            fatalError("Preview crash: \(error)")
        }
       
    }()
    
    
    // example data for preview
    static let example: [Transaction] = [
        Transaction(title: "Lunch", amount: 14, type: .expense),
        Transaction(title: "gift", amount: 100, type: .income),
        Transaction(title: "snacks", amount: 4, type: .expense),
        Transaction(title: "yesterday", amount: 15, type: .income, date: Calendar.current.date(byAdding: .day, value: -1, to: Date() )! ),
        Transaction(title: "tomorrow", amount: 28, type: .expense, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
    ]
    
}
