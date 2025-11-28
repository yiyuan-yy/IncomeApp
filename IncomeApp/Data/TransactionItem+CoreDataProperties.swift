//
//  TransactionItem+CoreDataProperties.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/28/25.
//
//

import Foundation
import CoreData
import SwiftUICore


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16

}

extension TransactionItem : Identifiable {

}

extension TransactionItem{
    // wrapped values
    var wrappedId: UUID {
        return id!
    }
    var wrappedTitle: String {
        return title ?? ""
    }
    var wrappeedType: TransactionType {
        return TransactionType(rawValue: Int(type)) ?? .expense
    }
    var wrappedDate: Date {
        return date ?? Date()
    }
    var wrappedAmount: Double {
        return amount
    }
    
    // helper computed values
    var number: Double{
        return  wrappeedType == .expense ? (wrappedAmount) * -1 : (wrappedAmount)
    }
    var formattedDate: String{
        return wrappedDate.formatted(date: .abbreviated, time: .omitted)
        
    }
    var typeImgName: String{
        return wrappeedType == .expense ? "arrow.down.right" : "arrow.up.right"
    }
    var typeImgColor: Color{
        return wrappeedType == .expense ? Color.red : Color.green
    }
}
