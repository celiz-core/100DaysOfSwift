import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.title), SortDescriptor(\Book.author)]) var books: [Book]
    
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    HStack {
                        NavigationLink(value: book) {
                            
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Add Book", systemImage: "plus") {
                        showingAddBookView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBookView) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) {
                DetailView(book: $0)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}


#Preview {
    ContentView()
}
