//
//  EditView.swift
//  BucketList
//
//  Created by user276992 on 8/15/25.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    @State private var loadingState: LoadingState = .loading
    @State private var pages = [Page]()
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    var onSave: (Location) -> Void
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby") {
                    switch loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            + Text(": ") +
                            
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Failed, try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var updatedLocation = location
                    updatedLocation.id = UUID()
                    updatedLocation.name = name
                    updatedLocation.description = description
                    onSave(updatedLocation)
                    
                    dismiss()
                }
                
                
            }
            .onAppear() {
                Task {
                    await fetchNearbyPlace()
                }
            }
        }
    }
        
        func fetchNearbyPlace() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    
    init(_ location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        
        self.onSave = onSave
    }
}

#Preview {
    
    NavigationStack {
        EditView(Location.example, onSave: {_ in })
    }
}
