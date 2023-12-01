//
//  iTomicApp.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import SwiftUI

@main
struct iTomicApp: App {
    @ObservedObject var iTomicVM = iTomicViewModel()
    @ObservedObject var budgetVM = BudgetViewModel()
    @ObservedObject var transactionVM = TransactionViewModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            //            if !iTomicApp.hasRunBefore {
            //                WelcomeView()
            //                    .environmentObject(iTomicApp)
            //                    .environmentObject(categoryVM)
            //                    .environmentObject(transactionVM)
            //
            //            } else {
            HomeScreen()
                .environmentObject(iTomicVM)
                .environmentObject(budgetVM)
                .environmentObject(transactionVM)
            
        }
    }
}
