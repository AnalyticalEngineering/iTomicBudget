//
//  HomeScreen.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import SwiftUI
import RealmSwift



struct HomeScreen: View {
    //MARK:  PROPERTIES
    @EnvironmentObject var iTomicVM: iTomicViewModel
    @EnvironmentObject var budgetVM: BudgetViewModel
    @EnvironmentObject var transactionVM: TransactionViewModel
    @ObservedResults(Budget.self) var budgets
    
    @State private var showAddTransaction: Bool = false
    @State private var showAddBudgetView: Bool = false
    @State private var selectedBudgetType: BudgetType = .expense
    @State private var showIconPicker: Bool = false
    @State private var selectedImage: String = "car.fill"
    private let adaptive =
    [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    
    
    var body: some View {
        //MARK:  SCORECARD / QUICK BALANCE
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom))  {
                ScrollView(.vertical, showsIndicators: false)  {
                    //MARK:  METRIC SCORECARD
                    LazyVGrid(columns: adaptive){
                        //MARK:  BALANCE
                        BudgetBalanceChart(amount: transactionVM.balance(), curren: iTomicVM.currencySymbol, type: NSLocalizedString("Balance", comment: "Balance"), icon: "equal.circle", iconBG: Color(Colors.colorBlue))
                        //MARK:  REMAINING BALANCE
                        BudgetBalanceChart(amount: transactionVM.averageDailyExpense(), curren: iTomicVM.currencySymbol, type: NSLocalizedString("Remaining Balance", comment: "Remaining Balance"), icon: "banknote", iconBG: Color(Colors.colorGreen))
                        //MARK:  INCOME
                        BudgetBalanceChart(amount: transactionVM.totalIncomes(), curren: iTomicVM.currencySymbol, type: NSLocalizedString("Income", comment: "Income"), icon: "plus.circle", iconBG: Color(Colors.colorGreen))
                        //MARK:  EXPENSE
                        BudgetBalanceChart(amount: transactionVM.totalExpenses(), curren: iTomicVM.currencySymbol, type: NSLocalizedString("Expense", comment: "Expense"), icon: "minus.circle", iconBG: Color(Colors.colorRed))
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    //MARK:   EXPENSE TYPE PICKER
                    Picker("Type:", selection: $selectedBudgetType) {
                        ForEach(BudgetType.allCases, id: \.self) { type in
                            Text(type.localizedName())
                        }
                    }
                 
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(Colors.colorBalanceBG))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                }
                .ignoresSafeArea()//#endOfScrollView
                .cornerRadius(10)
                .padding(.horizontal, 15)
                .padding(.bottom, 100)
                //
                let budgetsWithTransactionsArray = budgetVM.budgetsWithTransaction(budgets: budgets, type: selectedBudgetType)
                
                //
                var filteredBudgetsArray =  budgetVM.filteredBudgets(budgets: budgetsWithTransactionsArray, type: selectedBudgetType)
                
                //
                let _: () = filteredBudgetsArray.sort(by: { $0.budgetAmount(type: selectedBudgetType) > $1.budgetAmount(type: selectedBudgetType)})
                
                if filteredBudgetsArray.isEmpty {
                    // EmptyView()
                } else {
                    
                    ForEach(filteredBudgetsArray, id: \.self) { budget in
                        let totalAmount = budget.budgetAmount(type: selectedBudgetType)
                        NavigationLink(destination: TransactionBudgetView(selectedBudget: budget)) {
                            
                            BudgetItemView(budgetColor: budget.color, budgetIcon: budget.icon, budgetName: budget.name, totalAmount: totalAmount, currencySymbol: iTomicVM.currencySymbol)
                        }
                    }
                }
            }
           
           
            .padding(.all, 25)
            //MARK:  TOOL BAR
            .toolbar{
                //add new budget
                ToolbarItem( placement: .topBarTrailing) {
                    Button {
                        HapticManager.notification(type: .success)
                        showAddBudgetView = true
                    } label: {
                        HStack {
                            Text("Add Budget")
                                .foregroundStyle(.primary)
                                .font(.caption)
                            ZStack{
                                Circle()
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(.callout)
                            }
                        }
                        
                    }
                }
                //SideBarMenu
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        HapticManager.notification(type: .success)
                        print("menu")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                
            }
            .background(Color("colorBG"))
            .sheet(isPresented: $showAddBudgetView) {
                AddBudgetView()
                
                    .presentationDetents([
                        .height(600),   // 100 points
                        .fraction(0.8)])        // The previously default sheet size
                //   .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(iTomicViewModel())
            .environmentObject(TransactionViewModel())
            .environmentObject(BudgetViewModel())
    }
}
