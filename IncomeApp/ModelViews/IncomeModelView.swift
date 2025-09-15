//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class IncomeModelView: ObservableObject {
    @Published private(set) var transactions: [Transaction] = IncomeModelView.example
    
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
    var sortedTransactions: [Transaction]{
        return transactions.sorted{ $0.date > $1.date}
    }
    
    
    // Navigation controls
    @Published var showCreatePage = false
    
    // Create a record
    @Published var type: TransactionType = .expense
    @Published var amount: Double? = nil
    var formattedAmount: String{
        return String(format: "%.2f", amount ?? 0.0)
    }
    
    @Published var title: String = ""
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    func validateCreation() -> Bool{
        if amount == nil{
            showCreateAlert = true
            alertMessage = "Amount should not be empty!"
            return false
        } else if title == "" {
            showCreateAlert = true
            alertMessage = "Title should not be empty!"
            return false
        } else {
            showCreateAlert = false
            return true
        }
    }
    
    func createTransaction(){
        if  validateCreation() {
            transactions.append(Transaction(type: type, amount: amount ?? 0.0, title: title))
            // navigate back to home page
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(_ transaction: Transaction){
        transactions.removeAll{$0.id == transaction.id}
    }
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
