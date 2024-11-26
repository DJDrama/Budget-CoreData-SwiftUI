//
//  BudgetSummaryView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/26/24.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    // need for dynamic changes
    @ObservedObject var budgetCategory: BudgetCategory
    
    var body: some View {
        VStack{
            Text("\(budgetCategory.overSpent ? "Overspent":"Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overSpent ? .red: .green)
        }
    }
}
