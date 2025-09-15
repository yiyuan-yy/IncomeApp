//
//  CreateTransactionView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//

import SwiftUI

struct CreateTransactionView: View {
    @ObservedObject var incomeViewModel: IncomeModelView
    @State var textWidth: CGFloat = 20
    
    var body: some View {
        VStack(spacing: 30) {
            // Text Field for amount
            amountField

            Divider()
                .frame(height: 2)       // thickness
                .background(.lightGray)
                
            typePicker

            TextField("Title", text: $incomeViewModel.title)
                .textFieldStyle(.roundedBorder)
            
            submitButton
            
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
            Text(String(incomeViewModel.amount ?? 0.0))
                .foregroundStyle(.white.opacity(0))
                .overlay{
                    TextField("", value: $incomeViewModel.amount, format: .number.grouping(.automatic))
                    .minimumScaleFactor(0.1)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .lineLimit(1)
                }
        }
        .font(Fonts.big)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 30)
    }
    
    private var submitButton: some View{
        // Create button
        Button {
            incomeViewModel.createTransaction()
        } label: {
            Text("Create")
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.primaryTheme)
    }
    
    private var typePicker: some View {
        Picker("", selection: $incomeViewModel.type) {
            ForEach(TransactionType.allCases){type in
                Text(type.rawValue)
                  
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    CreateTransactionView(incomeViewModel: IncomeModelView())
}
