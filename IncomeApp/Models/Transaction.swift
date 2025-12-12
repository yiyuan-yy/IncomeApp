//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation
import SwiftUICore
import SwiftData

@Model class Transaction {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var amount: Double
    var type: TransactionType
    var date: Date
    
    init(title: String, amount: Double, type: TransactionType, date: Date = .now) {
        self.id = UUID()
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
    var typeImgColor: Color{
        return type == .expense ? Color.red : Color.green
    }
    
    
}
