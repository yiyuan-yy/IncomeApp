
//
//  AmountFieldView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

struct TypePickerView: View {
    @Binding var draft: Transaction
    var body: some View {
        Picker("", selection: $draft.type) {
            ForEach(TransactionType.allCases){type in
                Text(type.name)
                    .tag(type)
            }
        }
        .pickerStyle(.menu)
    }
}

