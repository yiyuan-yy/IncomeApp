//
//  CreateTransactionView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var incomeViewModel: TransactionViewModel
    @EnvironmentObject var settings: SettingStore

    var transactionToEdit: Transaction? = nil
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var amount: Double = 0.0
    @State private var date: Date = Date()
    @State private var type: TransactionType = .expense
    
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Text Field for amount
            AmountField

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGrayTheme)
                
            HStack {
                Picker("", selection: $type) {
                    ForEach(TransactionType.allCases){type in
                        Text(type.title)
                            .tag(type)
                    }
                }
                .pickerStyle(.menu)
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }

            TextField("Title", text: $title)
                .padding(.vertical)
                .textFieldStyle(.roundedBorder)
                .font(Constants.FontSize.dollarSign)
            
            Button {
                if let old = transactionToEdit{
                        if incomeViewModel.updateTransaction(
                            old,
                            title: title,
                            amount: amount,
                            type: type,
                            date: date) {
                            dismiss()
                        }
                } else {
                    incomeViewModel.createTransaction(
                        title: title,
                        amount: amount,
                        type: type,
                        date: date)
                }
            } label: {
                Text((transactionToEdit != nil) ? "Update" : "Create")
            }

            if let old = transactionToEdit{
                SubmitButtonView(label: "Update") {
                    if incomeViewModel.updateTransaction(old, title: title, amount: amount, type: type, date: date) {
                        dismiss()
                    }
                }
            } else {
                SubmitButtonView(label: "Create") {
                    incomeViewModel.createTransaction(title: title, amount: amount, type: type, date: date)
                }
            }
            
        }
        .padding()
        .infoAlert(isPresented: $incomeViewModel.showCreateAlert, message: incomeViewModel.alertMessage)
        .onAppear {
            if let transaction = transactionToEdit{
                title = transaction.title
                amount = transaction.amount
                type = transaction.type
                date = transaction.date
            }
        }

    }

    private var AmountField: some View{
        ZStack {
            Text(String((amount).formatted(.currency(code: settings.currencyType.title))))
                .foregroundColor(amount != 0.0 ? .white : .black)
            
            TextField("", value: $amount, format: .currency(code: settings.currencyType.title).grouping(.automatic))
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


#Preview {
    EditView(transactionToEdit: Transaction())
}
