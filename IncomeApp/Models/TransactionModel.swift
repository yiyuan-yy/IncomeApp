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
    var status: TransactionStatus = .completed
    
    //Mark Computed variables
    var number: Double{
        return  type == .expense ? (amount ?? 0.0) * -1 : (amount ?? 0.0)
    }
    var formattedDate: String{
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    var formattedAmount: String{
        return String(format: "%.2f", amount ?? 0.0)
    }
    var typeImgName: String{
        return type == .expense ? "arrow.down.right" : "arrow.up.right"
    }
    var typeImgColor: Color{
        return type == .expense ? Color.red : Color.green
    }
}

