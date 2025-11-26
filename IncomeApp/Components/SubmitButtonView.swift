//
//  SubmitButtonView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/16/25.
//

import SwiftUI

struct SubmitButtonView: View {
    let label: String
    let action: ()->Void
    
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.primaryTheme)
    }
}


