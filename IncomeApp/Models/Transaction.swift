//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation
import RealmSwift


class TransactionObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var amount: Double
    @Persisted var type: TransactionType
    @Persisted var date: Date
    
    convenience init(title: String, amount: Double, type: TransactionType, date: Date) {
        self.init()
        self.title = title
        self.amount = amount
        self.type = type
        self.date = date
    }
    
    var number: Double{
        return  type == .expense ? (amount) * -1 : (amount)
    }

    var formattedDate: String{
        return date.formatted(date: .abbreviated, time: .omitted)
    }

    var typeImgName: String{
        return type == .expense ? "arrow.down.right" : "arrow.up.right"
    }
}

struct Transaction: Identifiable {
    let id: ObjectId
    var title: String
    var amount: Double
    var date: Date
    var type: TransactionType
    
    var number: Double{
        return  type == .expense ? (amount) * -1 : (amount)
    }

    var formattedDate: String{
        return date.formatted(date: .abbreviated, time: .omitted)
    }

    var typeImgName: String{
        return type == .expense ? "arrow.down.right" : "arrow.up.right"
    }
}

extension Transaction {
    init(_ object: TransactionObject) {
        self.id = object.id
        self.title = object.title
        self.amount = object.amount
        self.date = object.date
        self.type = object.type
    }
}


enum TransactionType: Int, CaseIterable, Identifiable, PersistableEnum{
    var id: Self { return self }
    
    case income, expense
    
    var title: String{
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
