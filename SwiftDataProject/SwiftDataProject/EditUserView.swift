//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by user276992 on 8/13/25.
//

import SwiftUI
import SwiftData
struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    guard let container = try? ModelContainer(for: User.self, configurations: config) else {
        fatalError("Failed to generate mock data context")
    }
    let example = User(name: "Caleb", city: "Seattle", joinDate: Date())
    
    
    return EditUserView(user: example).modelContainer(container)
}
