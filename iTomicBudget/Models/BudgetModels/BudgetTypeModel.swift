//
//  BudgetTypeModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift

//MARK:  BUDGET TYPES
enum BudgetType: String, PersistableEnum, CaseIterable {
    //MARK:  (2) Transaction Buckets:   This is an expense, or this is income being added
    case expense = "Expense"
    case income = "Income"
    
    func localizedName() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
