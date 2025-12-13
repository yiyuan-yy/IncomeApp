//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation
import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = TransactionViewModel.example  //data
    @Published var settings: SettingStore //setting
    
    init(settings: SettingStore) {
        self.settings = settings
    }
    
    var shownTransactions: [Transaction] {
        return transactions.filter{settings.dateFilter.shouldInclude(date: $0.date)}.filter{$0.amount >= settings.minimumFilter}
    }
    
    // MARK: - Computed variables for the balance card
    var currencyCode: String {settings.currencyType.title}
    
    var balance: String {
        return String(shownTransactions.map{$0.number}.reduce(0.0,+).formatted(.currency(code: currencyCode)))
    }
    var totalExpense: String {
        return String(shownTransactions.map{$0.number}.filter{$0<0}.reduce(0.0, -).formatted(.currency(code: currencyCode)))
    }
    var totalIncome: String {
        return String(shownTransactions.map{$0.number}.filter{$0>0}.reduce(0.0, +).formatted(.currency(code: currencyCode)))
    }
    
    // MARK: - Transaction List
    var sortedDateKeys: [String]{
        return Array(shownTransactions.sorted{settings.sortDescending ? $0.date > $1.date : $0.date < $1.date}.map { $0.formattedDate }).uniqued()
    }
    
    func transactionsInDate(in date: String) -> [Transaction]?{
        return shownTransactions.filter{$0.formattedDate == date }.sorted{settings.sortDescending ? $0.date > $1.date : $0.date < $1.date}
    }
    
    
    // MARK: - CRUD of records
    // Navigation controls
    @Published var showUpdatePage = false
    @Published var showCreatePage = false
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    // Subscript
    private func index(of id: Transaction.ID) -> Int? {
        transactions.firstIndex(where: {$0.id == id})
    }
    
    func validate(title: String, amount: Double) -> Bool{
        if amount == 0.0{
            showCreateAlert = true
            alertMessage = "Amount should not be empty!"
            return false
        } else if title == "" {
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
    func createTransaction(title :String, amount: Double, type: TransactionType, date: Date){
        if  validate(title: title, amount: amount) {
            transactions.append(Transaction(title: title, amount: amount, type: type, date: date))
            // navigate back to home page
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(at offsets: IndexSet, in dateKey: String){
        guard let transactionInSection = transactionsInDate(in: dateKey) else {return}
        for index in offsets {
            let toDelete = transactionInSection[index]
            transactions.removeAll{$0.id == toDelete.id}
        }
    }
    
    // Update a record
    func updateTransaction(_ old: Transaction, title :String, amount: Double, type: TransactionType, date: Date) -> Bool{
        if  validate(title: title, amount: amount) {
            if let index = index(of: old.id){
                transactions[index].title = title
                transactions[index].amount = amount
                transactions[index].type = type
                transactions[index].date = date
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
        Transaction(title: "Lunch", amount: 14, type: .expense),
        Transaction(title: "gift", amount: 100, type: .income),
        Transaction(title: "snacks", amount: 4, type: .expense),
        Transaction(title: "yesterday", amount: 15, type: .income, date: Calendar.current.date(byAdding: .day, value: -1, to: Date() )! ),
        Transaction(title: "tomorrow", amount: 28, type: .expense, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
    ]
}

