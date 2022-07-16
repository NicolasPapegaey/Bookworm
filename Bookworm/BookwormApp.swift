//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Nicolas Papegaey on 11/06/2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
