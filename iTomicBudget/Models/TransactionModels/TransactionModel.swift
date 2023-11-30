//
//  TransactionModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift

class TransactionItem: Object, ObjectKeyIdentifiable {
    //MARK:  TRANSACTION ITEM PROPERTIES
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var budgetId: ObjectId = ObjectId.generate()
    @Persisted var amount: Float = 0
    @Persisted var note: String = ""
    @Persisted var date: Date = Date()
    @Persisted var type: BudgetType = .expense
    @Persisted(originProperty: "transactions") var budget: LinkingObjects<Budget>
}


