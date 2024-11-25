//
//  Budget_CoreData_SwiftUIApp.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import SwiftUI

@main
struct Budget_CoreData_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
