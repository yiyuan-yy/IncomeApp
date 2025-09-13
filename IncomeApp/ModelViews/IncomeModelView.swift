//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class IncomeModelView: ObservableObject {
    @Published var transactions: [Transaction] = IncomeModelView.example
    
    // Computed variables to show the total balance card based on transactions
    var balance: String {
        return String(format: "%.2f",transactions.map{$0.number}.reduce(0.0,+))
    }
    var totalExpense: String {
        return String(format: "%.2f",transactions.map{$0.number}.filter{$0<0}.reduce(0.0, -))
    }
    var totalIncome: String {
        return String(format: "%.2f",transactions.map{$0.number}.filter{$0>0}.reduce(0.0, +))
    }
    
    // Create a record
    @Published var type: TransactionType = .expense
    @Published var amount: Double = 0.0
    @Published var title: String = ""
    
    // Navigation controls
    @Published var showCreatePage = false
    
    // Delete a record
    func deleteTransaction(at offsets: IndexSet){
        transactions.remove(atOffsets: offsets)
    }
//    @Published var date: Date = Date()
//    
//    func addRecord(){
//        transactions.append(Transaction(type: type, amount: amount, title: title, date: date))
//    }
    // Update a record
    
}


extension IncomeModelView {
    static let example: [Transaction] = [
        Transaction(type: .expense, amount: 1, title: "Lunch"),
        Transaction(type: .income, amount: 2, title: "benefits"),
        Transaction(type: .expense, amount: 5, title: "dinner"),
        Transaction(type: .income, amount: 10, title: "gift"),
        Transaction(type: .expense, amount: 4, title: "snacks"),
        Transaction(type: .expense, amount: 5, title: "water expense"),
        
    ]
}
