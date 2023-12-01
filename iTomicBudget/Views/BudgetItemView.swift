//
//  BudgetView.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import SwiftUI



struct BudgetItemView: View {
    
    @EnvironmentObject var iTomicApp: iTomicViewModel
    
    let budgetColor: String
    let budgetIcon: String
    let budgetName: String
    let totalAmount: Float
    let currencySymbol: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                HStack {
                    Divider()
                        .foregroundColor(Color(budgetColor))
                        .frame(width: 5, height: 50)
                        .background(Color(budgetColor))
                }
                
                Image(systemName: budgetIcon)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .background(Color(budgetColor))
                    .cornerRadius(7.5)
                    .padding(0)
                
                Text(budgetName)
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color(Colors.mainText))
                
                Spacer()
                
                Text("\(totalAmount.formattedWithSeparatorAndCurrency(roundingNumbers: iTomicApp.roundingNumbers)) \(currencySymbol)")
                    .font(.headline).bold()
                    .foregroundColor(Color(Colors.mainText))
                
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color(Colors.mainText))
                    .opacity(0.5)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(Colors.colorBalanceBG))
            
            Divider()
        }
    }
}

struct BudgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetItemView(budgetColor: Colors.colorBlue, budgetIcon: "plus", budgetName: "Food", totalAmount: 100, currencySymbol: "$")
    }
}

