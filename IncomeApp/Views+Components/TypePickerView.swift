//
//  TypePickerView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 11/27/25.
//

import SwiftUI

struct TypePickerView: View {
    @Binding var draft: Transaction
    var body: some View {
        Picker("", selection: $draft.type) {
            ForEach(TransactionType.allCases){type in
                Text(type.title)
                    .tag(type)
            }
        }
        .pickerStyle(.menu)
    }
}
