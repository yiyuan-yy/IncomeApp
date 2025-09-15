//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = TransactionViewModel.example
    
    // Computed variables to show the total balance card based on transactions
    var balance: String {
        return String(transactions.map{$0.number}.reduce(0.0,+).formatted(.currency(code: "USD")))
    }
    var totalExpense: String {
        return String(transactions.map{$0.number}.filter{$0<0}.reduce(0.0, -).formatted(.currency(code: "USD")))
    }
    var totalIncome: String {
        return String(transactions.map{$0.number}.filter{$0>0}.reduce(0.0, +).formatted(.currency(code: "USD")))
    }
    var sortedTransactions: [Transaction]{
        return transactions.sorted{ $0.date > $1.date}
    }
    
    // Navigation controls
    @Published var showCreatePage = false
    @Published var showUpdatePage = false
    
    // Create a record
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    func validateCreation(_ transaction: Transaction) -> Bool{
        guard let amount = transaction.amount else {
            showCreateAlert = true
            alertMessage = "Amount should not be empty!"
            return false
        }
        if amount == 0.0{
            showCreateAlert = true
            alertMessage = "Amount should not be empty!"
            return false
        } else if transaction.title == "" {
            showCreateAlert = true
            alertMessage = "Title should not be empty!"
            return false
        } else {
            showCreateAlert = false
            return true
        }
    }
    
    func createTransaction(_ transaction: Transaction){
        if  validateCreation(transaction) {
            transactions.append(transaction)
            // navigate back to home page
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(_ transaction: Transaction){
        transactions.removeAll{$0.id == transaction.id}
    }
    // Update a record
//    @Published var newTransaction: Transaction? = nil
    @Published var showUpdateAlert = false
    @Published var updateAlertMessage = ""
    
}


extension TransactionViewModel {
    static let example: [Transaction] = [
        Transaction(type: .expense, amount: 1, title: "Lunch"),
        Transaction(type: .income, amount: 2, title: "benefits"),
        Transaction(type: .expense, amount: 5, title: "dinner"),
        Transaction(type: .income, amount: 10, title: "gift"),
        Transaction(type: .expense, amount: 4, title: "snacks"),
        Transaction(type: .expense, amount: 5, title: "water expense"),
        
    ]
}
