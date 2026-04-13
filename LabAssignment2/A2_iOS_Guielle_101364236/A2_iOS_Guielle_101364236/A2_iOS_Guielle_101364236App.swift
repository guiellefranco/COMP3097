//
//  A2_iOS_Guielle_101364236App.swift
//  A2_iOS_Guielle_101364236
//
//  Created by Guielle Mikhailavich Yre Franco on 2026-04-12.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_Guielle_101364236App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
