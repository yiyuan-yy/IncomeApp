//
//  AmountFieldView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

struct AmountFieldView: View {
    @Binding var draft: Transaction
    var currency: Currency
    
    var body: some View {
        ZStack {
            Text(String((draft.amount ?? 0.0).formatted(.currency(code: currency.rawValue))))
                .foregroundColor(draft.amount != nil ? .white : .black)
            
            TextField("", value: $draft.amount, format: .currency(code: currency.rawValue).grouping(.automatic))
                .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                .textFieldStyle(.plain)
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .lineLimit(1)
                .multilineTextAlignment(.center)

        }
        .font(Constants.FontSize.big)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 30)
    }
}

