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
                .font(Constants.FontSize.body)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(.lightGrayTheme)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
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
                        Text("US\(transaction.formattedAmount)")
                            
                    }
                    .font(Constants.FontSize.subtitle)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .truncationMode(.tail)
//                    HStack{
//                        Text("Completed")
//                        Spacer()
//                    }
//                    .font(Constants.FontSize.body)
                }
            }
            
        }
        .padding(.horizontal)
    }
}
