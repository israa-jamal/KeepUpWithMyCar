//
//  KeepUpWithMyCarApp.swift
//  KeepUpWithMyCar
//
//  Created by Esraa Gamal on 10/01/2023.
//

import SwiftUI

@main
struct KeepUpWithMyCarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, Repository.shared.persistentContainer.viewContext)
        }
    }
}
