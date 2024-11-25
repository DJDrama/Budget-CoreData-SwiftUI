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
    
    var body: some View {
        NavigationStack{
            VStack {
                List(budgetCategoryResults) { budgetCategory in
                    Text(budgetCategory.title ?? "")
                }
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
