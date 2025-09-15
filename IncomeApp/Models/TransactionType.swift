//
//  TransactionType.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation

enum TransactionType: String, CaseIterable, Identifiable{
    var id: Self {
        return self
    }
    
    case income = "Income"
    case expense = "Expense"
}
