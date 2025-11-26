//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation
import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published private(set) var allTransactions: [Transaction] = TransactionViewModel.example
    
    // MARK: - settings
    
    // filtered transactions by date and minimum filter
    @AppStorage("dateFilter") var dateFilter: DateFilterType = .thisMonth  // time filter
    @AppStorage("minimumFilter") var minimumFilter: Double = 0.0     // minimum filter
    
    var transactions: [Transaction] {
        return allTransactions.filter{dateFilter.shouldInclude(date: $0.date)}.filter{($0.amount ?? 0.0) >= minimumFilter}
    }
    
    // sort order
    @AppStorage("sortDescending") var sortDescending = true
    
    // currency
    @AppStorage("currency") var currencyType: Currency = .CNY
    
    // MARK: - Computed variables for the balance card
    var balance: String {
        return String(transactions.map{$0.number}.reduce(0.0,+).formatted(.currency(code: currencyType.rawValue)))
    }
    var totalExpense: String {
        return String(transactions.map{$0.number}.filter{$0<0}.reduce(0.0, -).formatted(.currency(code: currencyType.rawValue)))
    }
    var totalIncome: String {
        return String(transactions.map{$0.number}.filter{$0>0}.reduce(0.0, +).formatted(.currency(code: currencyType.rawValue)))
    }
    
    // MARK: - Transaction List
    var sortedDateKeys: [String]{
        return Array(transactions.sorted{sortDescending ? $0.date > $1.date : $0.date < $1.date}.map { $0.formattedDate }).uniqued()
    }
    
    func transactionsInDate(in date: String) -> [Transaction]?{
        return transactions.filter{$0.formattedDate == date }.sorted{sortDescending ? $0.date > $1.date : $0.date < $1.date}
    }
    
    
    // MARK: - CRUD of records
    // Navigation controls
    @Published var showUpdatePage = false
    @Published var showCreatePage = false
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    // Subscript
    private func index(of id: Transaction.ID) -> Int? {
        allTransactions.firstIndex(where: {$0.id == id})
    }
    
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
    
    // Create a record
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

// MARK: - example data
extension TransactionViewModel {
    static let example: [Transaction] = [
        Transaction(type: .expense, amount: 14, title: "Lunch"),
        Transaction(type: .income, amount: 100, title: "gift"),
        Transaction(type: .expense, amount: 4, title: "snacks")
    ]
}

