//
//  ContentView.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/12/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            VStack {
                settingButton
                titleView
                overviewCard
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    private var overviewCard: some View{
        VStack (spacing: 10) {
            HStack {
                Text("BALANCE")
                Spacer()
            }
            HStack {
                Text("ToTal Number $")
                    .font(.system(size: 40))
                Spacer()
            }
            HStack {
                VStack{
                    Text("EXPENSE")
                    Text("US$0.00")
                }
                VStack{
                    Text("Income")
                    Text("US$0.00")
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
    
    private var titleView: some View{
        HStack {
            Text("Income")
                .font(.system(size: 30, weight: .heavy))
            Spacer()
            
        }
    }
    
    private var settingButton: some View{
        HStack {
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 20))
        }
    }
    
}

#Preview {
    HomeView()
}
