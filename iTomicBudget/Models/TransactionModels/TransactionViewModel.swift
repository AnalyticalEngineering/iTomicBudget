//
//  TransactionViewModel.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation
import RealmSwift

final class TransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionItem] = []
    
    init() {
        loadData()
    }
    
  
    func loadData() {
        guard let realm = try? Realm() else {
            print("Ошибка: loadData")
            return
        }
        let transactionsResult = realm.objects(TransactionItem.self)
        transactions = Array(transactionsResult)
    }
    
    // Метод сохранения транзакции
    func saveTransaction(amount: Float, date: Date, note: String, type: BudgetType, budget: Budget) {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать экземпляр Realm")
            return
        }
        if let newBudget = realm.object(ofType: Budget.self, forPrimaryKey: budget.id) {
            let newTransaction = TransactionItem()
            newTransaction.budgetId = newBudget.id
            newTransaction.amount = amount
            newTransaction.date = date
            newTransaction.note = note
            newTransaction.type = type
            do {
                try realm.write {
                    newBudget.transactions.append(newTransaction)
                }
                
                // Обновляю список транзакций после сохранения
                transactions.append(newTransaction)
                
                // Отладочное сообщение
                print("Транзакция сохранена: \(newTransaction)")
            } catch {
                // Отладочное сообщение
                print("Ошибка сохранения транзакции: \(error)")
            }
        } else {
            // Отладочное сообщение, если категория не найдена
            print("Ошибка: категория не найдена")
        }
    }
    
    // Метод для удаления транзакций
    private func deleteTransaction(withId id: ObjectId) {
        do {
            let realm = try Realm()
            
            if let transaction = realm.object(ofType: TransactionItem.self, forPrimaryKey: id) {
                try realm.write {
                    if let budget = transaction.budget.first {
                        if let index = budget.transactions.firstIndex(of: transaction) {
                            budget.transactions.remove(at: index)
                        }
                    }
                    realm.delete(transaction)
                }
                loadData()
            } else {
                print("Транзакция с ID \(id) не найдена")
            }
        } catch let error {
            print("Ошибка удаления транзакции: \(error)")
        }
    }
    
    // Метод удаления транзакций
    func deleteTransaction(at offsets: IndexSet, from sortedTransactions: [TransactionItem]) {
        offsets.forEach { index in
            let transaction = sortedTransactions[index]
            deleteTransaction(withId: transaction.id)
        }
    }
    
    // MARK: TransactionView
    // Метод для группировки транзакций по дате
    func transactionsByDate(_ transactions: [TransactionItem]) -> [Date: [TransactionItem]] {
        var groupedTransactions: [Date: [TransactionItem]] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        for transaction in transactions {
            let dateString = dateFormatter.string(from: transaction.date)
            if let date = dateFormatter.date(from: dateString) {
                if groupedTransactions[date] == nil {
                    groupedTransactions[date] = []
                }
                groupedTransactions[date]?.append(transaction)
            }
        }
        
        return groupedTransactions
    }
    
    // Метод фильтрации категорий
    func filterBudgets(budgets: [Budget], transaction: TransactionItem) -> Budget? {
        for budget in budgets {
            if budget.id == transaction.budgetId {
                return budget
            }
        }
        return nil
    }
    
    // метод сортировки транзакций по дате
    func sortTransactionsByDate(transactions: [TransactionItem]) -> [TransactionItem] {
        return transactions.sorted(by: { $0.date > $1.date })
    }
    
    // MARK: TransactionCategoryView
    // метод фильтрации транзакции с выбранной категорией
    func filterTransaction(budget: Budget, transactions: [TransactionItem]) -> [TransactionItem] {
        var groupedTransaction: [TransactionItem] = []
        
        for transaction in transactions {
            if budget.id == transaction.budgetId {
                groupedTransaction.append(transaction)
            }
        }
        return groupedTransaction
    }
    
    // MARK: AddTransactionView
    // метод фильтрации транзакций для отбора уникальных заметок
    func filterTransactionsNote(budget: Budget, transactions: [TransactionItem]) -> [TransactionItem] {
        var groupedTransaction: [TransactionItem] = []
        var uniqueNotes: [String] = []
        
            for transaction in transactions.prefix(20) {
                if budget.id == transaction.budgetId {
                if transaction.note.count != 0 {
                    if !uniqueNotes.contains(transaction.note.description) {
                        uniqueNotes.append(transaction.note.description)
                        groupedTransaction.append(transaction)
                    }
                }
            }
        }
        return groupedTransaction
    }
    
    // MARK: HomeView
    // Считает расход
    func totalExpenses() -> Float {
        var expenses: Float = 0
        for transaction in transactions {
            if transaction.type == .expense {
                expenses += transaction.amount
            }
        }
        return expenses
    }
    
    // Считает доход
    func totalIncomes() -> Float {
        var icncome: Float = 0
        for transaction in transactions {
            if transaction.type == .income {
                icncome += transaction.amount
            }
        }
        return icncome
    }
    
    // Считает балланс
    func balance() -> Float {
        return totalIncomes() - totalExpenses()
    }
    
    // Расчет среднего расхода за день, сначала нахожу общее количество дней c транзакциями, а затем разделим общую сумму расходных транзакций на количество дней
    func averageDailyExpense() -> Float {
        let expenseTransactions = transactions.filter { $0.type == .expense }
        guard !expenseTransactions.isEmpty else {
            return 0
        }
        
        let uniqueExpenseDates = Set(expenseTransactions.map { transaction -> Date in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: transaction.date)
            return calendar.date(from: components) ?? transaction.date
        })
        
        let daysWithTransactions = uniqueExpenseDates.count
        
        let totalExpenseAmount = totalExpenses()
        
        return totalExpenseAmount / Float(daysWithTransactions)
    }
}
