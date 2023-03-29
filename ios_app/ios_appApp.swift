//
//  ios_appApp.swift
//  ios_app
//
//  Created by Kenneth Wu on 2022/12/5.
//

import SwiftUI

@main
struct ios_appApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            //let _ = dataController.UpdateFromIoT()
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }

}

//@main
//struct newApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}
