//
//  DetailView.swift
//  Bookworm
//
//  Created by user276992 on 8/12/25.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDelete = false
    
    var book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDelete) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Delete", role: .destructive) {
                    showingDelete.toggle()
                }
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    //let container = ModelContainer(for: Book.self, configurations: config)
    guard let container = try? ModelContainer(for: Book.self, configurations: config) else {
        fatalError("Could not create model container")
    }
    
    
    let example = Book(title: "title", author: "Caleb Elizondo", genre: "Fantasy", review:  "It was OK i guess", rating: 4)
        
    return NavigationStack {
        DetailView(book: example).modelContainer(container)
    }

}
