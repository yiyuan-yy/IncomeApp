//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var incomeViewModel = TransactionViewModel()
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
                CreateView(incomeViewModel: incomeViewModel)
            }
            .navigationTitle("Income")
            .toolbar(.hidden, for: .navigationBar)
            .animation(.spring, value: hideOverview)
        
        }
    }
    
    private var transactionsListView: some View{
        List{
            ForEach(incomeViewModel.sortedTransactions){transaction in
                NavigationLink(destination: UpdateView(incomeViewModel: incomeViewModel, transaction: transaction)) {
                    TransactionCardView(transaction: transaction)
                }
            }
            .onDelete {indexSet in
                for index in indexSet {
                    let toDelete = incomeViewModel.sortedTransactions[index]
                    incomeViewModel.deleteTransaction(toDelete)
                }
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
                    .font(Constants.FontSize.addButtonImg)
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
                Text("BALANCE US\(incomeViewModel.balance)")
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
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
                Text("US \(incomeViewModel.balance)")
                    .font(Constants.FontSize.dollarSign)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .truncationMode(.tail)
                Spacer()
            }
            HStack {
                VStack(alignment:.leading) {
                    Text("EXPENSE")
                    Text("US\(incomeViewModel.totalExpense)")
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                        .truncationMode(.tail)
                }
                VStack(alignment:.leading) {
                    Text("INCOME")
                    Text("US\(incomeViewModel.totalIncome)")
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                        .truncationMode(.tail)
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
                .font(Constants.FontSize.title)
            Spacer()
            
        }
    }
    
    private var settingButton: some View{
        HStack {
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(Constants.FontSize.subtitle)
        }
    }
    
}

#Preview {
    HomeView()
}


