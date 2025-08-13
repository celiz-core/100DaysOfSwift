//
//  AddBookView.swift
//  Bookworm
//
//  Created by user276992 on 8/12/25.
//

import Foundation
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContent
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContent.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}


#Preview {
    AddBookView()
}
