//
//  BudgetListView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if budgetCategoryResults.isEmpty {
                Text("No budget category exists!")
            } else {
                ForEach(budgetCategoryResults) { budgetCategory in
                    HStack {
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack {
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.map { index in
                        budgetCategoryResults[index]
                    }.forEach { budgetCategory in
                        onDeleteBudgetCategory(budgetCategory)
                    }
                })
            }
        }
    }
}
