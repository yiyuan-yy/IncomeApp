//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

struct HomeView: View {
    let exampleTransactions: [Transaction] = IncomeModelView.example
    
    var body: some View {
        VStack {
            VStack {
                settingButton
                titleView
                overviewCard
            }
            .padding(.horizontal)
            
            List (exampleTransactions) {transaction in
                TransactionCardView(transaction: transaction)
            }
            .listStyle(.inset)
            
            Spacer()
            
            addRecordButton

        }
    }
    
    private var addRecordButton: some View{
        HStack{
            Button {
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .font(.system(size: 70, weight: .thin))
                    .foregroundStyle(.white, .primaryTheme)
                    .shadow(color: .primaryTheme, radius: 3)
            }
        }
    }
    
    private var overviewCard: some View{
        VStack (spacing: 10) {
            HStack {
                Text("BALANCE")
                Spacer()
            }
            HStack {
                Text("ToTal Number $")
                    .font(.system(size: 40))
                Spacer()
            }
            HStack {
                VStack{
                    Text("EXPENSE")
                    Text("US$0.00")
                }
                VStack{
                    Text("Income")
                    Text("US$0.00")
                }
                Spacer()
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.primaryTheme)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 8)
    }
    
    private var titleView: some View{
        HStack {
            Text("Income")
                .font(.system(size: 30, weight: .heavy))
            Spacer()
            
        }
    }
    
    private var settingButton: some View{
        HStack {
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 20))
        }
    }
    
}

#Preview {
    HomeView()
}

struct TransactionCardView: View {
    let transaction: Transaction
    var body: some View {
        VStack {
            // a date view
            Text(transaction.formattedDate)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack {
                VStack{
                    Image(systemName: transaction.typeImgName)
                        .font(.system(size:20,weight: .bold))
                        .foregroundStyle(transaction.typeImgColor)
                }
                VStack {
                    HStack{
                        Text(transaction.title)
                        Spacer()
                        Text("US$\(transaction.formattedAmount)")
                    }
                    .font(.system(size: 20, weight: .bold))
                    HStack{
                        Text("\(transaction.status)")
                        Spacer()
                    }
                    .font(.system(size: 20))
                }
            }
            
        }
        .padding(.horizontal)
    }
}
