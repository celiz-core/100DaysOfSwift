//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by user276992 on 8/13/25.
//

import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
