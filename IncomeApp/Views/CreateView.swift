//
//  CreateTransactionView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//

import SwiftUI

struct CreateView: View {
    @ObservedObject var incomeViewModel: TransactionViewModel
    @State private var draft: Transaction = Transaction()
    
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
            
            SubmitButtonView(label: "Create") {
                incomeViewModel.createTransaction(draft)
            }
            
        }
        .padding()
        .infoAlert(isPresented: $incomeViewModel.showCreateAlert, message: incomeViewModel.alertMessage)

    }

}


#Preview {
    CreateView(incomeViewModel: TransactionViewModel())
}
