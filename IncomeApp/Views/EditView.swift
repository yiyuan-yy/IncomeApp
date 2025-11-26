//
//  CreateTransactionView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var incomeViewModel: TransactionViewModel
    @State private var draft: Transaction = Transaction()
    var transactionToEdit: Transaction? = nil
    @Environment(\.dismiss) private var dismiss
    
    init(incomeViewModel: TransactionViewModel, transactionToEdit: Transaction?) {
        self.incomeViewModel = incomeViewModel
        if let transaction = transactionToEdit{
            self.transactionToEdit = transaction
            self._draft = State(initialValue: transaction)
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Text Field for amount
            AmountFieldView(draft: $draft, currency: incomeViewModel.currency)

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGrayTheme)
                
            HStack {
                TypePickerView(draft: $draft)
                DatePicker("", selection: $draft.date, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }

            TextField("Title", text: $draft.title)
                .padding(.vertical)
                .textFieldStyle(.roundedBorder)
                .font(Constants.FontSize.dollarSign)
            
            if let old = transactionToEdit{
                SubmitButtonView(label: "Update") {
                    if incomeViewModel.updateTransaction(old: old, new: draft) {
                        dismiss()
                    }
                }
            } else {
                SubmitButtonView(label: "Create") {
                    incomeViewModel.createTransaction(draft)
                }
            }
            
        }
        .padding()
        .infoAlert(isPresented: $incomeViewModel.showCreateAlert, message: incomeViewModel.alertMessage)

    }

}


#Preview {
    EditView(incomeViewModel: TransactionViewModel(), transactionToEdit: Transaction())
}
