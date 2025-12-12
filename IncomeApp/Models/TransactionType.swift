//
//  TransactionType.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//
import Foundation

enum TransactionType: Int, CaseIterable, Identifiable, Codable{
    var id: Self {
        return self
    }
    
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
