//
//  iOS_TimeragoApp.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/04/28.
//

import SwiftUI

@main
struct iOS_TimeragoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
