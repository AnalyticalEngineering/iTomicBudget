//
//  BudgetBalanceChart.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import SwiftUI

struct BudgetBalanceChart: View {
    //MARK:  PROPERTIES
    @EnvironmentObject var iTomicVM: iTomicViewModel
    
    let amount: Float
    let curren: String
    let type: String
    let icon: String
    let iconBG: Color
    var body: some View {
        VStack {
            VStack {
                        HStack {
                                Image(systemName: icon)
                                .foregroundStyle(Color(Colors.colorBlack))
                                .font(.title)
                                .background(iconBG)
                                .cornerRadius(7.5)
                            Spacer()
                            Text("\(amount.formattedWithSeparatorAndCurrency(roundingNumbers: iTomicVM.roundingNumbers)) \(curren)")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                        }
                HStack {
                    Text(type)
                        .foregroundColor(.black).textCase(.uppercase)
                        .font(.subheadline).dynamicTypeSize(.small)
                } .padding(.top, 5)
            }
            .padding(10)
            .padding(.vertical, 5)
            .background(Color(Colors.colorBalanceBG))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
struct BudgetBalanceChartView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetBalanceChart(amount: 1000, curren: "$", type: "expense", icon: "calendar", iconBG: .blue)
    }
}

