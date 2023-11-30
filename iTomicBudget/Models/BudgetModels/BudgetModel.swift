//
//  BudgetModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift

class Budget: Object, ObjectKeyIdentifiable {
//MARK:  PROPERTIES
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var name: String = ""
    @Persisted var icon: String = ""
    @Persisted var color: String = ""
    @Persisted var type: BudgetType = .expense
    @Persisted var transactions: List<TransactionItem> = List<TransactionItem>()
    
 //MARK:  HAS TRANSACTIONS FUNCTION
    func hasTransactions(type: BudgetType) -> Bool {
        for transaction in transactions {
            if transaction.type == type {
                return true
            }
        }
        return false
    }
    
//MARK:  BUDGET AMOUNT
    func budgetAmount(type: BudgetType) -> Float {
        var totalAmount: Float = 0
        for transaction in transactions {
            if transaction.type == type {
                totalAmount += transaction.amount
            }
        }
        return totalAmount
    }
}

