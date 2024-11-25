//
//  CoreDataManager.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer
    
    private init(){
        self.persistentContainer = NSPersistentContainer(name: "BudgetModel")
        self.persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize Core Data stack \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
