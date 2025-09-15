//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var incomeViewModel = IncomeModelView()
    @State var hideOverview = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    settingButton
                    titleView
                    balanceCard
                }
                .padding(.horizontal)
                
                transactionsListView
               
                Spacer()
                
                addRecordButton
                
            }
            .navigationDestination(isPresented: $incomeViewModel.showCreatePage) {
                CreateTransactionView(incomeViewModel: incomeViewModel)
            }
            .navigationTitle("Income")
            .toolbar(.hidden, for: .navigationBar)
            .animation(.spring, value: hideOverview)
        
        }
    }
    
    private var transactionsListView: some View{
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
        
    }
    
    private var addRecordButton: some View{
        HStack{
            Button {
                incomeViewModel.showCreatePage = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .font(Fonts.addButtonImg)
                    .foregroundStyle(.white, .primaryTheme)
                    .shadow(color: .primaryTheme, radius: 3)
            }
        }
    }
    
    private var balanceCard: some View{
        VStack{
            if hideOverview {
                hiddenOverviewCard
            }
            if !hideOverview {
                overviewCard
            }
        }
    }
    
    private var hiddenOverviewCard: some View{
        VStack {
            HStack {
                Text("BALANCE US$\(incomeViewModel.balance)")
                Spacer()
                Button {
                    hideOverview = false
                } label: {
                    Image(systemName: "eye")
                }
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.primaryTheme)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 8)
        
    }
    
    private var overviewCard: some View{
        VStack (alignment:.leading, spacing: 10) {
            HStack {
                Text("BALANCE")
                Spacer()
                Button {
                    hideOverview = true
                } label: {
                    Image(systemName: "eye.slash")
                }
            }
            HStack {
                Text("US$ \(incomeViewModel.balance)")
                    .font(Fonts.dollarSign)
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
                .font(Fonts.title)
            Spacer()
            
        }
    }
    
    private var settingButton: some View{
        HStack {
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(Fonts.subtitle)
        }
    }
    
}

#Preview {
    HomeView()
}


