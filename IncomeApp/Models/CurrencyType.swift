//
//  Currency.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/24/25.
//

enum CurrencyType: Int, CaseIterable, Identifiable {
    case USD, CNY
    
    var id: Self{return self}
    
    var title: String{
        switch self {
        case .USD:
            return "USD"
        case .CNY:
            return ""
        }CNY
    }
    
    var sign: String {
        switch self {
        case .USD:
            return "$"
        case .CNY:
            return "¥"
        }
    }
}
