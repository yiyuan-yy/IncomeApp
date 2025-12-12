//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation
import SwiftUI
import SwiftData

class TransactionViewModel: ObservableObject {
    @Published var settings: SettingStore //setting
    
    init(settings: SettingStore) {
        self.settings = settings
    }
    
    func shownTransactions(for transactions: [Transaction]) -> [Transaction] {
        return transactions.filter{settings.dateFilter.shouldInclude(date: $0.date)}.filter{$0.amount >= settings.minimumFilter}.sorted{settings.sortDescending ? $0.date > $1.date : $0.date < $1.date}
    }
    
    // MARK: - Computed variables for the balance card
    var currencyCode: String {settings.currencyType.title}
    
    func balance(for transactions: [Transaction]) -> String {
        return String(shownTransactions(for: transactions).map{$0.number}.reduce(0.0,+).formatted(.currency(code: currencyCode)))
    }
    func totalExpense(for transactions: [Transaction]) -> String {
        return String(shownTransactions(for: transactions).map{$0.number}.filter{$0<0}.reduce(0.0, -).formatted(.currency(code: currencyCode)))
    }
    func totalIncome(for transactions: [Transaction]) -> String {
        return String(shownTransactions(for: transactions).map{$0.number}.filter{$0>0}.reduce(0.0, +).formatted(.currency(code: currencyCode)))
    }
    
    // MARK: - Transaction List
    func sortedDateKeys(for transactions: [Transaction]) -> [String]{
        return Array(shownTransactions(for: transactions).map { $0.formattedDate }).uniqued()
    }
    
    func transactionsInDate(for transactions: [Transaction], in date: String) -> [Transaction]?{
        return shownTransactions(for: transactions).filter{$0.formattedDate == date }
    }
    
    
    // MARK: - CRUD of records
    // Navigation controls
    @Published var showUpdatePage = false
    @Published var showCreatePage = false
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    // Subscript
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
    func createTransaction(modelContext: ModelContext, title :String, amount: Double, type: TransactionType, date: Date){
        if  validate(title: title, amount: amount) {
            let t = Transaction(title: title, amount: amount, type: type, date: date)
            modelContext.insert(t)
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(modelContext: ModelContext, transactions: [Transaction], at offsets: IndexSet, in dateKey: String){
        guard let items = transactionsInDate(for: transactions, in: dateKey) else {return}
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
    
    // Update a record
    func updateTransaction(modelContext: ModelContext, old: Transaction, title :String, amount: Double, type: TransactionType, date: Date) -> Bool{
        if  validate(title: title, amount: amount) {
            old.title = title
            old.amount = amount
            old.type = type
            old.date = date
            return true
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

