//
//  TransactionRepositoryProtocol.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//

import CoreData

protocol TransactionRepositoryProtocol {
    func fetchTransactions() -> [TransactionItem]
    func addTransaction(title: String, amount: Double, type: TransactionType, date: Date)
    func update(_ transaction: TransactionItem, title: String,
                amount: Double, type: TransactionType, date: Date)
    func delete(_ transaction: TransactionItem)
    func save()
}

final class TransactionRepository: TransactionRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func fetchTransactions() -> [TransactionItem] {
        let request: NSFetchRequest<TransactionItem> = TransactionItem.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func addTransaction(title: String, amount: Double, type: TransactionType, date: Date) {
        let item = TransactionItem(context: context)
        item.id = UUID()
        item.title = title
        item.amount = amount
        item.type = Int16(type.rawValue)
        item.date = date
        save()
    }
    
    func update(_ transaction: TransactionItem, title: String,
                amount: Double, type: TransactionType, date: Date){
        transaction.title = title
        transaction.amount = amount
        transaction.type = Int16(type.rawValue)
        transaction.date = date
        save()
    }
    
    func delete(_ transaction: TransactionItem) {
        context.delete(transaction)
        save()
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
    

    
}
