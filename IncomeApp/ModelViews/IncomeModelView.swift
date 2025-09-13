//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class IncomeModelView: ObservableObject {
    @Published var transactions: [Transaction] = []
    var balance: Double {
        return transactions.map{$0.number}.reduce(0.0,+)
    }
    
    // Create a record
    @Published var type: TransactionType = .expense
    @Published var amount: Double = 0.0
    @Published var title: String = ""
    
    // Navigation controls
    @Published var showCreatePage = false
//    @Published var date: Date = Date()
//    
//    func addRecord(){
//        transactions.append(Transaction(type: type, amount: amount, title: title, date: date))
//    }
    // Update a record
    
}


extension IncomeModelView {
    static let example: [Transaction] = [
        Transaction(type: .expense, amount: 1.5, title: "Lunch"),
        Transaction(type: .income, amount: 5264, title: "benefits"),
        Transaction(type: .expense, amount: 25, title: "dinner"),
        Transaction(type: .income, amount: 1314, title: "gift"),
        Transaction(type: .expense, amount: 10, title: "snacks"),
        Transaction(type: .expense, amount: 5, title: "water expense"),
        
    ]
}
