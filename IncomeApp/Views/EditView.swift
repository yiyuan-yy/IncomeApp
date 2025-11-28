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

    var transactionToEdit: TransactionItem? = nil
    @Environment(\.dismiss) private var dismiss
    
    @State private var amount: Double = 0.0
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var type: TransactionType = .expense
    
    init(transactionToEdit: TransactionItem?) {
        if let transaction = transactionToEdit{
            self.transactionToEdit = transaction
            self._amount = State(initialValue: transaction.wrappedAmount)
            self._date = State(initialValue: transaction.wrappedDate)
            self._title = State(initialValue: transaction.wrappedTitle)
            self._type = State(initialValue: transaction.wrappeedType)
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Text Field for amount
            AmountFieldView(amount: $amount, currency: settings.currencyType)

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGrayTheme)
                
            HStack {
                TypePickerView(type: $type)
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }

            TextField("Title", text: $title)
                .padding(.vertical)
                .textFieldStyle(.roundedBorder)
                .font(Constants.FontSize.dollarSign)
            
            if let old = transactionToEdit{
                SubmitButtonView(label: "Update") {
                    if incomeViewModel.updateTransaction(old, title: title,
                                                         amount: amount, type: type,
                                                         date: date) {
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

    }

}


#Preview {
    EditView(transactionToEdit: nil)
}
