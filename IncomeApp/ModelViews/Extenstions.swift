//
//  Extenstions.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import Foundation



extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}


