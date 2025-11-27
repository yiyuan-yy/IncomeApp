//
//  TransactionCardView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//
import SwiftUI

struct TransactionCardView: View {
    let transaction: Transaction
    var currency: CurrencyType
    
    var body: some View {
        VStack {
            HStack {
                VStack{
                    Image(systemName: transaction.typeImgName)
                        .font(Constants.FontSize.subtitle)
                        .foregroundStyle(transaction.typeImgColor)
                }
                VStack {
                    HStack{
                        Text(transaction.title)
                        Spacer()
                        Text(String((transaction.amount).formatted(.currency(code: currency.rawValue)) ))
                            
                    }
                    .font(Constants.FontSize.subtitle)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .truncationMode(.tail)
                }
            }
            
        }
        .padding(.horizontal)
    }
}
