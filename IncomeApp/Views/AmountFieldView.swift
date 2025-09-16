//
//  AmountFieldView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

struct AmountFieldView: View {
    @Binding var draft: Transaction
    var body: some View {
        HStack {
            Text("US$")
            Text(String(draft.amount ?? 0.0))
                .foregroundStyle(.white.opacity(0))
                .overlay{
                    TextField("", value: $draft.amount, format: .number.grouping(.automatic))
                        .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .lineLimit(1)
                }
        }
        .font(Constants.FontSize.big)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 30)
    }
}

