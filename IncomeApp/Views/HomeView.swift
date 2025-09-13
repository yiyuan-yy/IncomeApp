//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var incomeViewModel = IncomeModelView()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    settingButton
                    titleView
                    overviewCard
                }
                .padding(.horizontal)
                
                List{
                    ForEach(incomeViewModel.transactions){transaction in
                        TransactionCardView(transaction: transaction)
                    }
                    .onDelete {indexSet in
                        incomeViewModel.deleteTransaction(at: indexSet)
                    }
                }
                .listStyle(.inset)
                .toolbar{
                    EditButton()
                }
                
                Spacer()
                
                addRecordButton
                
            }
            .navigationDestination(isPresented: $incomeViewModel.showCreatePage) {
                CreateTransactionView(incomeViewModel: incomeViewModel)
            }
            .navigationTitle("Income")
            .toolbar(.hidden, for: .navigationBar)
        
        }
    }
    
    private var addRecordButton: some View{
        HStack{
            Button {
                incomeViewModel.showCreatePage = true
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
        VStack (alignment:.leading, spacing: 10) {
            HStack {
                Text("BALANCE")
                Spacer()
            }
            HStack {
                Text("US$ \(incomeViewModel.balance)")
                    .font(.system(size: 40))
                Spacer()
            }
            HStack {
                VStack(alignment:.leading) {
                    Text("EXPENSE")
                    Text("US$\(incomeViewModel.totalExpense)")
                }
                VStack(alignment:.leading) {
                    Text("INCOME")
                    Text("US$\(incomeViewModel.totalIncome)")
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


