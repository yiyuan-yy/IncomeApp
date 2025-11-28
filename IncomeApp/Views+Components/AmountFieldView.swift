//
//  AmountFieldView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

struct AmountFieldView: View {
    @Binding var amount: Double
    var currency: CurrencyType
    
    var body: some View {
        ZStack {
            Text(String((amount).formatted(.currency(code: currency.rawValue))))
                .foregroundColor(amount != 0.0 ? .white : .black)
            
            TextField("", value: $amount, format: .currency(code: currency.rawValue).grouping(.automatic))
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

