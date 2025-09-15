
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
            amountField

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGrayTheme)
                
            typePicker

            TextField("Title", text: $draft.title)
                .textFieldStyle(.roundedBorder)
            
            updateButton
            
        }
        .padding()
        .alert("", isPresented: $incomeViewModel.showCreateAlert) {
            Button {
                incomeViewModel.showCreateAlert = false
            } label: {
                Text("OK")
            }
        } message: {
            Text(incomeViewModel.alertMessage)
        }

    }
    
    private var amountField: some View{
        HStack {
            Text("US$")
            Text(String(draft.amount ?? 0.0))
                .foregroundStyle(.white.opacity(0))
                .overlay{
                    TextField("", value:  $draft.amount, format: .number.grouping(.automatic))
                    .minimumScaleFactor(Constants.ScaleFactor.textShrink)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .lineLimit(1)
                }
        }
        .font(Constants.FontSize.big)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 30)
    }
    
    private var updateButton: some View{
        // Create button
        Button {
            if incomeViewModel.updateTransaction(old: transaction, new: draft) {
                dismiss()
            }
        } label: {
            Text("Update")
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.primaryTheme)
    }
    
    private var typePicker: some View {
        Picker("", selection: $draft.type) {
            ForEach(TransactionType.allCases){type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    UpdateView(incomeViewModel: TransactionViewModel(), transaction: Transaction())
}
