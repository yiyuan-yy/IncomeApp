//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published private(set) var allTransactions: [Transaction] = TransactionViewModel.example
    
    // filtered transactions by date
    @Published var filterType: DateFilterType = .thisMonth
    var transactions: [Transaction] {
        return allTransactions.filter{filterType.shouldInclude(date: $0.date)}
    }
    
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
    
    // Transaction List
    var sortedDateKeys: [String]{
        return Array(transactions.sorted{$0.date > $1.date}.map { $0.formattedDate }).uniqued()
    }
    
    func transactionsInDate(in date: String) -> [Transaction]?{
        return transactions.filter{$0.formattedDate == date }.sorted{$0.date>$1.date}
    }
    
    // Navigation controls
    @Published var showCreatePage = false
    @Published var showUpdatePage = false
    
    // Create a record
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    func validate(_ transaction: Transaction) -> Bool{
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
            alertMessage = ""
            return true
        }
    }
    
    func createTransaction(_ transaction: Transaction){
        if  validate(transaction) {
            allTransactions.append(transaction)
            // navigate back to home page
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(at offsets: IndexSet, in dateKey: String){
        guard let transactionInSection = transactionsInDate(in: dateKey) else {return}
        for index in offsets {
            let toDelete = transactionInSection[index]
            allTransactions.removeAll{$0.id == toDelete.id}
        }
    }
    
    // Subscript
    private func index(of id: Transaction.ID) -> Int? {
        allTransactions.firstIndex(where: {$0.id == id})
    }
    
    // Update a record
    func updateTransaction(old: Transaction, new: Transaction) -> Bool{
        if  validate(old) {
            if let index = index(of: old.id){
                allTransactions[index] = new
                return true
            } else {
                return false
            }
        }
        return false
    }
}


extension TransactionViewModel {
    static let example: [Transaction] = [
        Transaction(type: .expense, amount: 1, title: "Lunch"),
        Transaction(type: .income, amount: 10, title: "gift"),
        Transaction(type: .expense, amount: 4, title: "snacks")
        
    ]
}

