//
//  ViewModel.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//

import Foundation
/*
 Core Date Storage
 1. Persistence Container -> Entity
    Object Graph Management
    Persisitence Store Coodinator
    Persistence -> SQLite
 2. DataManager -> Manage Object Context
 3. Create
 4. Read -> FetchRequest
 5. Update
 6. Delete
 7. In memory Persistence Store (for Preview)
 */

@MainActor
final class TransactionViewModel: ObservableObject {
    // MARK: - Data
    @Published private(set) var transactions: [TransactionItem] = []
    
    private let repository: TransactionRepositoryProtocol
    @Published var settings: SettingStore // insert settings
    
    init(repository: TransactionRepositoryProtocol = TransactionRepository(),
         settings: SettingStore = SettingStore()
    ){
        self.repository = repository
        self.settings = settings
        load()
    }
    
    func load() {
        transactions = repository.fetchTransactions()
    }
    
    // MARK: - Transaction List
    // shown transactions
    var shownTransactions: [TransactionItem] {
        return transactions.filter{settings.dateFilter.shouldInclude(date: $0.wrappedDate)}.filter{$0.wrappedAmount >= settings.minimumFilter}
    }

    var sortedDateKeys: [String]{
        return Array(shownTransactions.sorted{settings.sortDescending ? $0.wrappedDate > $1.wrappedDate : $0.wrappedDate < $1.wrappedDate}.map { $0.formattedDate }).uniqued()
    }
    
    func transactionsInDate(in date: String) -> [TransactionItem]?{
        return shownTransactions.filter{$0.formattedDate == date }.sorted{settings.sortDescending ? $0.wrappedDate > $1.wrappedDate : $0.wrappedDate < $1.wrappedDate}
    }
    
    // Computed variables for the balance card
    var currencyCode: String { return settings.currencyType.title }
    var balance: String {
        return String(shownTransactions.map{$0.number}.reduce(0.0,+).formatted(.currency(code: currencyCode)))
    }
    var totalExpense: String {
        return String(shownTransactions.map{$0.number}.filter{$0<0}.reduce(0.0, -).formatted(.currency(code: currencyCode)))
    }
    var totalIncome: String {
        return String(shownTransactions.map{$0.number}.filter{$0>0}.reduce(0.0, +).formatted(.currency(code: currencyCode)))
    }
    
    
    // MARK: - CRUD of records
    // Navigation controls
    @Published var showUpdatePage = false
    @Published var showCreatePage = false
    @Published var showCreateAlert = false
    @Published var alertMessage = ""
    
    
    func validate(amount: Double, title: String) -> Bool{
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
    func createTransaction(title: String, amount: Double, type: TransactionType, date: Date){
        if  validate(amount: amount, title: title) {
            repository.addTransaction(title: title, amount: amount, type: type, date: date)
            load()
            // navigate back to home page
            showCreatePage = false
        }
    }
    
    // Delete a record
    func deleteTransaction(at offsets: IndexSet, in dateKey: String){
        guard let transactionInSection = transactionsInDate(in: dateKey) else {return}
        for index in offsets {
            let toDelete = transactionInSection[index]
            repository.delete(toDelete)
            load()
        }
    }
    
    // Update a record
    func updateTransaction(_ item: TransactionItem, title: String,
                           amount: Double, type: TransactionType,
                           date: Date) -> Bool{
        if  validate(amount: amount, title: title) {
            repository.update(item, title: title, amount: amount, type: type, date: date)
            load()
            return true
        }
        return false
    }
}


