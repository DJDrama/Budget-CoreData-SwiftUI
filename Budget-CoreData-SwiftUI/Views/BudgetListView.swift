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
                    NavigationLink(value: budgetCategory){
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment:.trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "Overspent":"Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red: .green)
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.map { index in
                        budgetCategoryResults[index]
                    }.forEach { budgetCategory in
                        onDeleteBudgetCategory(budgetCategory)
                    }
                })
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}
