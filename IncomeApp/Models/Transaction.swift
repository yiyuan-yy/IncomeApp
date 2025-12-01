//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation
import SwiftUICore

struct Transaction: Identifiable {
    let id = UUID()
    var title: String = ""
    var amount: Double = 0.0
    var type: TransactionType = .expense
    var date: Date = Date()
}

//Mark Computed variables
extension Transaction {
    var number: Double{
        return  type == .expense ? (amount) * -1 : (amount)
    }
    var formattedDate: String{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter.string(from: date)
        return date.formatted(date: .abbreviated, time: .omitted)
        
    }

    var typeImgName: String{
        return type == .expense ? "arrow.down.right" : "arrow.up.right"
    }
    var typeImgColor: Color{
        return type == .expense ? Color.red : Color.green
    }
}

