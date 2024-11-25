//
//  AddBudgetCategoryView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var total: Double = 0.0
    @State private var messages: [String] = []
    
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
    
    private func save(){
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        // save the context
        do{
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
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
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            save()
                        } else {
                            
                        }
                    }
                }
            })
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}
