//
//  ContentView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    
    @State private var isPresented: Bool = false
    
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory){
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save() // need "Save()" after "Delete()"
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                BudgetListView(budgetCategoryResults: self.budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory)
            }
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category"){
                        isPresented = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
