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
    
    init(request: NSFetchRequest<Transaction>) {
        _transactions = FetchRequest(fetchRequest: request)
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
                }
            }
        }
    }
}