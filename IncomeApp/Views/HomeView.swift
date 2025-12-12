//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject var incomeViewModel: TransactionViewModel
    @EnvironmentObject var settings: SettingStore
    @State private var hideOverview = false
    @State private var showSettingView = false
    
    @Environment(\.modelContext) private var context
    @Query var transactions: [Transaction]
    
    var body: some View {
        NavigationStack {
            VStack {
                BalanceCard
                    .padding(.horizontal)
                
                TransactionsList
               
                Spacer()
                
                AddRecordButton
                
            }
            .navigationDestination(isPresented: $incomeViewModel.showCreatePage) {
                EditView( transactionToEdit: nil)
            }
            .navigationTitle("Income")
            .toolbar{
                ToolbarItemGroup {
                    PeriodPicker
                    
                    Button {
                        showSettingView = true
                    } label: {
                        Image(systemName: "gear")
                    }

                }
            }
            .sheet(isPresented: $showSettingView, content: {
                SettingView()
                    .environmentObject(incomeViewModel)
            })
            .animation(.spring, value: hideOverview)
            
        }
    }
    
    private var TransactionsList: some View{
        List{
            ForEach(incomeViewModel.sortedDateKeys(for: transactions), id: \.self){key in
                Section (header: DateInList(key) ){
                    ForEach(incomeViewModel.transactionsInDate(for: transactions, in: key) ?? []){transaction in
                        NavigationLink(destination: EditView(transactionToEdit: transaction )) {
                            TransactionCardView(transaction: transaction, currency: settings.currencyType)
                        }
                    }
                    .onDelete { indexSet in
                        incomeViewModel.deleteTransaction(
                            modelContext: context, transactions: transactions,
                            at: indexSet,
                            in: key
                        )
                    }
                }
            }
        }
        .listStyle(.inset)
    }
    
    private func DateInList(_ date: String) -> some View{
        // a date view
        Text(date)
            .font(Constants.FontSize.body)
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .background(.lightGrayTheme)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var AddRecordButton: some View{
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
    
    private var BalanceCard: some View{
        VStack{
            if hideOverview {
                HiddenBalanceCard
            }
            if !hideOverview {
                FullBalanceCard
            }
        }
    }
    
    private var HiddenBalanceCard: some View{
        VStack {
            HStack {
                Text("BALANCE \(incomeViewModel.balance(for: transactions))")
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
    
    private var FullBalanceCard: some View{
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
                Text(incomeViewModel.balance(for: transactions))
                    .font(Constants.FontSize.dollarSign)
                    .lineLimit(1)
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .truncationMode(.tail)
                Spacer()
            }
            HStack(spacing: 25) {
                VStack(alignment:.leading) {
                    Text("EXPENSE")
                    Text(incomeViewModel.totalExpense(for: transactions))
                        .lineLimit(1)
                        .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                        .truncationMode(.tail)
                }
                VStack(alignment:.leading) {
                    Text("INCOME")
                    Text(incomeViewModel.totalIncome(for: transactions))
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
    
    private var PeriodPicker: some View{
        Picker("", selection: $settings.dateFilter) {
            ForEach(DateFilterType.allCases){type in
                Text(type.name)
            }
        }
    }
    
}

#Preview {
    let settings = SettingStore()
    HomeView()
        .environmentObject(settings)
        .environmentObject(TransactionViewModel(settings: settings))
}


