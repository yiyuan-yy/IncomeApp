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
    
    //Mark Computed variables
    var number: Double{
        return  type == .expense ? amount * -1 : amount
    }
}

