//
//  ContentView.swift
//  Bookworm
//
//  Created by Nicolas Papegaey on 11/06/2022.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var books: FetchedResults<Book>
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        }
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unkown Title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .primary)
                            Text(book.author ?? "Unkown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
