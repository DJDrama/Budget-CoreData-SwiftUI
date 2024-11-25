//
//  BudgetCategory+CoreDataClass.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {

    // whenever you create BudgetCategory object, this method will run
    public override func awakeFromInsert() {
        self.dateCreated = Date() // default date
    }
}
