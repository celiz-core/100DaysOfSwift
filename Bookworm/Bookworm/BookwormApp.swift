//
//  BookwormApp.swift
//  Bookworm
//
//  Created by user276992 on 8/12/25.
//



import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
