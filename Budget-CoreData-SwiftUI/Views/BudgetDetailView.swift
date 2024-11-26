//
//  BudgetDetailView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/26/24.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let budgetCategory: BudgetCategory
    @State private var title: String = ""
    @State private var total: String = ""
    
    
    private var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false }
        return !title.isEmpty && totalAsDouble>=0
    }
    
    private func saveTransaction() {
        
        do{
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            

            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
        }catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Budget:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                    
                }
            }.padding()
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                HStack{
                    Spacer()
                    Button("Save Transaction"){
                        // save transaction
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
            }
            
            // Summary
            BudgetSummaryView(budgetCategory: self.budgetCategory)
            
            // Transaction
            TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory))
            Spacer()
        }
    }
}
