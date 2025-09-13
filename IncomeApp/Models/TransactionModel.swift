//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    var type: TransactionType = .expense
    var amount: Double = 0.0
    var title: String = ""
    var date: Date
    
    //Mark Computed variables
    var number: Double{
        return  type == .expense ? amount * -1 : amount
    }
    var formattedDate: String{
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.timeStyle = .none
        return formatter.string(from: date)
        
    }
    
}

