//
//  Repository.swift
//  IncomeApp
//
//  Created by yiyuan hu on 12/15/25.
//

import Foundation
import RealmSwift

protocol TransactionRepositoryProtocol {
    func fetchAll() -> [Transaction]
    func add(_ transaction: Transaction)
    func update(id: ObjectId, title: String, amount: Double, date: Date, type: TransactionType)
    func delete(id: ObjectId)
}


final class TransactionRepository: TransactionRepositoryProtocol {

    private let realm = try! Realm()

    func fetchAll() -> [Transaction] {
        realm.objects(TransactionObject.self)
            .map(Transaction.init)
    }

    func add(_ transaction: Transaction) {
        try? realm.write {
            realm.add(TransactionObject(title: transaction.title, amount: transaction.amount, type: transaction.type, date: transaction.date))
        }
    }

    func update(id: ObjectId, title: String, amount: Double, date: Date, type: TransactionType) {
        guard let obj = realm.object(ofType: TransactionObject.self, forPrimaryKey: id)
        else {
            print("id not found")
            return
        }
        
        print("id \(id.description) found")
        
        try? realm.write {
            obj.title = title
            obj.amount = amount
            obj.date = date
            obj.type = type
        }
    }

    func delete(id: ObjectId) {
        guard let obj = realm.object(ofType: TransactionObject.self, forPrimaryKey: id)
        else { return }

        try? realm.write {
            realm.delete(obj)
        }
    }
}
