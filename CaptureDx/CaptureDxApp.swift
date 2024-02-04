//
//  CaptureDxApp.swift
//  CaptureDx
//
//  Created by Janice Liu on 2/2/24.
//

import SwiftUI

@main
struct CaptureDxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    
    
}
