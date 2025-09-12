//
//  IncomeModelView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import Foundation

class IncomeModelView: ObservableObject {
    @Published var transactions: [Transaction] = []
    var balance: Double {
        return transactions.map{$0.number}.reduce(0.0,+)
    }
    
    // Create a record
    @Published var type: TransactionType = .expense
    @Published var amount: Double = 0.0
    @Published var title: String = ""
    
    func addRecord(){
        transactions.append(Transaction(type: type, amount: amount, title: title))
    }
    // Update a record
    
}
