//
//  Currency.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/24/25.
//

enum Currency: String, CaseIterable, Identifiable {
    case USD, CNY
    
    var id: Self{return self}
    
    var sign: String {
        switch self {
        case .USD:
            return "$"
        case .CNY:
            return "¥"
        }
    }
}
