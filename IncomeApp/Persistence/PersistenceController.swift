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
