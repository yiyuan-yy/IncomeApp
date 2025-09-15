//
//  TransactionCardView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//
import SwiftUI

struct TransactionCardView: View {
    let transaction: Transaction
    var body: some View {
        VStack {
            // a date view
            Text(transaction.formattedDate)
                .font(Fonts.body)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(.lightGrayTheme)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack {
                VStack{
                    Image(systemName: transaction.typeImgName)
                        .font(Fonts.subtitle)
                        .foregroundStyle(transaction.typeImgColor)
                }
                VStack {
                    HStack{
                        Text(transaction.title)
                        Spacer()
                        Text("US$\(transaction.formattedAmount)")
                    }
                    .font(Fonts.subtitle)
                    HStack{
                        Text("\(transaction.status)")
                        Spacer()
                    }
                    .font(Fonts.body)
                }
            }
            
        }
        .padding(.horizontal)
    }
}
