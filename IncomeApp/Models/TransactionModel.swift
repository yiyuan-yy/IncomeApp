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
    var type: TransactionType = .expense
    var amount: Double? = nil
    var title: String = ""
    var date: Date = Date()
}

//Mark Computed variables
extension Transaction {
    var number: Double{
        return  type == .expense ? (amount ?? 0.0) * -1 : (amount ?? 0.0)
    }
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    var formattedAmount: String{
        return String( (amount ?? 0.0).formatted(.currency(code: "USD")) )
    }
    var typeImgName: String{
        return type == .expense ? "arrow.down.right" : "arrow.up.right"
    }
    var typeImgColor: Color{
        return type == .expense ? Color.red : Color.green
    }
}

