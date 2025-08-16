//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by user276992 on 8/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @State private var path = [User]()
    
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add user") {
                    let newUser = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(newUser)
                    path = [newUser]
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
