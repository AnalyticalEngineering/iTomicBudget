//
//  TransactionBudgetView.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import SwiftUI
import RealmSwift

struct TransactionBudgetView: View {
    @EnvironmentObject var appVM: iTomicViewModel
    @EnvironmentObject var transactionVM: TransactionViewModel
    @ObservedResults(TransactionItem.self) var transactions
    
    @State var selectedBudget: Budget
    
    var filteredTransactions: [TransactionItem] {
        transactionVM.filterTransaction(budget: selectedBudget, transactions: Array(transactions))
    }
    
    var body: some View {
        List {
            if transactions.isEmpty {
        Text("previewCardTransaction()")        /*previewCardTransaction()*/
            } else {
                let groupedTransactions = transactionVM.transactionsByDate(Array(filteredTransactions))
                ForEach(groupedTransactions.keys.sorted(by: { $0 > $1 }), id: \.self) { date in
                    Section(header: Text(date, style: .date).bold()) {
                        let sortedTransactions = transactionVM.sortTransactionsByDate(transactions: groupedTransactions[date]!)
                        
                        ForEach(sortedTransactions, id: \.self) { transaction in
                            NavigationLink(destination: EditTransactionView()) {
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        HStack {
                                            Divider()
                                                .foregroundColor(Color(selectedBudget.color))
                                                .frame(width: 5, height: 72)
                                                .background(Color(selectedBudget.color))
                                        } .padding(.trailing, 3)
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                if transaction.type == BudgetType.expense {
                                                    Text("-\(transaction.amount.formattedWithSeparatorAndCurrency(roundingNumbers: appVM.roundingNumbers)) \(appVM.currencySymbol)")
                                                        .font(.title3).bold()
                                                } else {
                                                    Text("\(transaction.amount.formattedWithSeparatorAndCurrency(roundingNumbers: appVM.roundingNumbers)) \(appVM.currencySymbol)")
                                                        .font(.title3).bold()
                                                }
                                                Spacer()
                                                HStack {
                                                    Text(selectedBudget.name)
                                                        .foregroundColor(Color("colorBalanceText")).textCase(.uppercase)
                                                        .font(.caption)
                                                        .multilineTextAlignment(.trailing)
                                                        .dynamicTypeSize(.small)
                                                        .padding(0)
                                                    Image(systemName: selectedBudget.icon)
                                                        .font(.caption).dynamicTypeSize(.small)
                                                        .foregroundColor(.black)
                                                        .frame(width: 20, height: 20)
                                                        .background(Color(selectedBudget.color))
                                                        .cornerRadius(5)
                                                        .padding(0)
                                                } .padding(0)
                                            }
                                            HStack {
                                                Text(transaction.note)
                                                    .foregroundColor(Color(.gray)).textCase(.uppercase)
                                                    .font(.subheadline).dynamicTypeSize(.small)
                                                Spacer()
                                                Text(selectedBudget.type.localizedName())
                                                    .foregroundColor(Color(.gray)).textCase(.uppercase)
                                                    .font(.subheadline).dynamicTypeSize(.small)
                                            }
                                        }    .padding(.leading, 10)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(height: 50)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            transactionVM.deleteTransaction(at: indexSet, from: sortedTransactions)
                            HapticManager.notification(type: .success)
                        })
                    }
                }
            }
        }
        .navigationTitle(selectedBudget.name)
        .background(Color("colorBG"))
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if transactions.isEmpty {
                    EditButton().disabled(true)
                } else {
                    EditButton()
                }
            }
        }
    }
}

struct TransactionCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionBudgetView( selectedBudget: Budget())
    }
}
