
//
//  CreateView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//

import SwiftUI

struct UpdateView: View {
    @ObservedObject var incomeViewModel: TransactionViewModel
    let transaction: Transaction
    @State private var draft: Transaction
    @Environment(\.dismiss) private var dismiss
    
    init(incomeViewModel: TransactionViewModel, transaction: Transaction) {
        self.incomeViewModel = incomeViewModel
        self.transaction = transaction
        self._draft = State(initialValue: transaction)
    }
   
    var body: some View {
        VStack(spacing: 30) {
            // Text Field for amount
            AmountFieldView(draft: $draft)

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGrayTheme)
                
            TypePickerView(draft: $draft)

            TextField("Title", text: $draft.title)
                .textFieldStyle(.roundedBorder)
            
            SubmitButtonView(label: "Update") {
                if incomeViewModel.updateTransaction(old: transaction, new: draft) {
                    dismiss()
                }
            }
        }
        .padding()
        .infoAlert(isPresented: $incomeViewModel.showCreateAlert, message: incomeViewModel.alertMessage)
    }
    
    
}

#Preview {
    UpdateView(incomeViewModel: TransactionViewModel(), transaction: Transaction())
}
