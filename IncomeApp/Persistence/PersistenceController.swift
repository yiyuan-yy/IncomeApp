//
//  PersistenceController.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//
import Foundation
import CoreData


// Singleton
struct PersistenceController {
    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = PersistenceController()
    
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        for i in 0..<5 {
            let newItem = TransactionItem(context: viewContext)
            newItem.title = "Mock \(i)"
            newItem.amount = Double(i*20)
            newItem.date = Date()
            newItem.type = 0
            newItem.id = UUID()
        }
        try? viewContext.save()
        return controller
    }()
    
    
    private init(inMemory: Bool = false){
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ CoreData failed to load: \(error)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
