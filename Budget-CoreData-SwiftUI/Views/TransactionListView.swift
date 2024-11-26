//
//  TransactionListView.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/26/24.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    
    let onDeleteTransaction: (Transaction) -> Void
    
    // @escaping : out leave this function
    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    var body: some View {
        if transactions.isEmpty {
            Text("No Transactions")
                .padding()
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack{
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }.onDelete(perform: deleteTransaction)
            }
        }
    }
    private func deleteTransaction(_ indexSet: IndexSet){
        indexSet.map { transactions[$0] }
            .forEach { transaction in
                    onDeleteTransaction(transaction)
            }
    }
}
