//
//  ExtensionView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

extension View {
    func infoAlert(isPresented: Binding<Bool>, message: String) -> some View {
        self.alert("", isPresented: isPresented) {
            Button("OK") {
                isPresented.wrappedValue = false
            }
        } message: {
            Text(message)
        }
    }
}
