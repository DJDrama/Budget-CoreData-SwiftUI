//
//  TransactionCategory+CoreDataClass.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/26/24.
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
