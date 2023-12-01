//
//  BudgetViewModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift

final class BudgetViewModel: ObservableObject {
    @Published var budgets: [Budget] = []
    
    init() {
        loadData()
    }
    
    // MARK:  LOAD DATA
    func loadData() {
        guard let realm = try? Realm() else {
            print("DATED NOT LOADED")
            return
        }
        let BudgetsResult = realm.objects(Budget.self)
        budgets = Array(BudgetsResult)
    }
    
 
//    func createDefaultBudgetCategories() {
//        guard let realm = try? Realm() else {
//            print("Ошибка: Не удалось создать категории по умолчанию Realm")
//            return
//        }
//        
//   //     let defaultBudgetCategory = defaultBudgetCategoriesModel
//        
//        try! realm.write {
//            for budget in defaultBudgetCategory {
//                realm.add(budget)
//            }
//        }
//    }
    
   
    func saveBudget(name: String, icon: String, color: String, type: BudgetType) {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать экземпляр Realm")
            return
        }
        let newBudget = Budget()
        newBudget.name = name
        newBudget.icon = icon
        newBudget.color = color
        newBudget.type = type
        do {
            try realm.write {
                realm.add(newBudget)
            }
           
            return print("Категория сохранена: \(newBudget)")
        } catch {
          
            return print("Ошибка сохранения категории: \(error)")
        }
    }
    
   
    func deleteBudget(id: ObjectId) {
        do {
            let realm = try Realm()
            if let budget = realm.object(ofType: Budget.self, forPrimaryKey: id) {
                try realm.write {
                    
                    for transaction in budget.transactions {
                        realm.delete(transaction)
                    }
                    
                    
                    realm.delete(budget)
                }
                loadData()
            }
        } catch {
            print("Error deleting budget: \(error)")
        }
    }
    
    // MARK: HomeScreen
    func filteredBudgets(budgets: [Budget], type: BudgetType) -> [Budget] {
        var result: [Budget] = []
        for budget in budgets {
            if budget.budgetAmount(type: type) > 0 {
                result.append(budget)
            }
        }
        return result
    }
    
   
    func budgetsWithTransaction(budgets: Results<Budget>, type: BudgetType) -> [Budget] {
        var result: [Budget] = []
        for budget in budgets {
            if budget.hasTransactions(type: type) {
                result.append(budget)
            }
        }
        return result
    }
    
    // MARK: BudgetView
    func filteredBudget(budget: Results<Budget>, type: BudgetType) -> [Budget] {
        return budget.filter { $0.type == type
        }
    }
    
    func deleteBudgets(budget: Results<Budget>, at offsets: IndexSet, type: BudgetType, transaction: TransactionViewModel) {
        let filtered = filteredBudget(budget: budget, type: type)
        offsets.forEach { index in
            deleteBudget(id: filtered[index].id)
            loadData()
            transaction.loadData()
        }
    }
}
