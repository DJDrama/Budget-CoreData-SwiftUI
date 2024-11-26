//
//  AddBudgetCategoryView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    private var budgetCategoryForEdit: BudgetCategory?
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var total: Double = 0.0
    @State private var messages: [String] = []
    
    init(budgetCategoryForEdit: BudgetCategory? = nil){
        self.budgetCategoryForEdit = budgetCategoryForEdit
    }
    
    var isFormValid: Bool {
        
        messages.removeAll()
        
        if title.isEmpty {
            messages.append("Title is required.")
        }
        if total <= 0 {
            messages.append("Total should be greater than 0")
        }
        return messages.isEmpty
    }
    
    private func saveOrUpdate() {
        if let budgetCategoryForEdit {
            // get the budget that you need to update.
            let budget = BudgetCategory.byId(budgetCategoryForEdit.objectID)
            
            // update the existing budget category
            budget.title = title
            budget.total = total      
        }
        else {
            // save a new budget category
            let budgetCategory = BudgetCategory(context: viewContext)
            budgetCategory.title = title
            budgetCategory.total = total
        }
        
        do {
            try viewContext.save()
            dismiss()
        }catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text(0 as NSNumber, formatter: NumberFormatter.currency)
                } maximumValueLabel: {
                    Text(500 as NSNumber, formatter: NumberFormatter.currency)
                }
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(messages, id: \.self) { message in
                    Text(message)
                }
            }.toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            saveOrUpdate()
                        } else {
                            
                        }
                    }
                }
            })
        }
        .onAppear {
            if let budgetCategoryForEdit {
                title = budgetCategoryForEdit.title ?? ""
                total = budgetCategoryForEdit.total
                
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}
