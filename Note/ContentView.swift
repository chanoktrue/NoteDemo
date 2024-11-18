//
//  ContentView.swift
//  Note
//
//  Created by Thongchai Subsaidee on 12/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var notes: [Note]
    
    @State private var isShowCreateNote: Bool = false
    @State private var sort = SortDescriptor(\Note.title)
    
    @State private var search: String = ""
    
    var body: some View {
        NavigationStack {
            NoteListView(sort: sort, searchKeyworkd: search)
            .navigationTitle("Note")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Text("\(notes.count) Note")
                        .font(.footnote)
                    Spacer()
                    Button("Create note", systemImage: "square.and.pencil"){
                        isShowCreateNote.toggle()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu("Sort Menu", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort Picker", selection: $sort) {
                            Text("Title")
                                .tag(SortDescriptor(\Note.title))
                            Text("Last Updated")
                                .tag(SortDescriptor(\Note.lastUpdated, order: .reverse))
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowCreateNote) {
                CreateNoteView()
            }
            .searchable(text: $search)
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Note.self, configurations: config)
    
    let notes: [Note] = [
        Note(title: "Epiphany", isPinned: false, content: "Today I realized the importance of taking regular breaks to boost productivity.", lastUpdated: Date().addingTimeInterval(-500000)),
        Note(title: "Euphoria", isPinned: true, content: "Had a wonderful time at the park with friends. The weather was perfect!", lastUpdated: Date().addingTimeInterval(-300000)),
        Note(title: "Reverie", isPinned: false, content: "I spent the afternoon daydreaming about my next vacation destination.", lastUpdated: Date().addingTimeInterval(-700000)),
        Note(title: "Solitude", isPinned: true, content: "Enjoyed a peaceful evening reading my favorite book in solitude.", lastUpdated: Date().addingTimeInterval(-200000)),
        Note(title: "Aurora", isPinned: false, content: "Woke up early to catch the sunrise. The colors were absolutely breathtaking.", lastUpdated: Date().addingTimeInterval(-800000)),
        Note(title: "Odyssey", isPinned: true, content: "Started planning my next big adventure. Can't wait to explore new places!", lastUpdated: Date().addingTimeInterval(-400000)),
        Note(title: "Enigma", isPinned: false, content: "Solved a challenging puzzle today. It felt great to finally figure it out.", lastUpdated: Date().addingTimeInterval(-600000)),
        Note(title: "Nostalgia", isPinned: true, content: "Found an old photo album and spent hours reminiscing about the good old days.", lastUpdated: Date().addingTimeInterval(-100000)),
        Note(title: "Serendipity", isPinned: false, content: "Bumped into an old friend unexpectedly. It was a delightful surprise!", lastUpdated: Date().addingTimeInterval(-900000)),
        Note(title: "Elysium", isPinned: true, content: "Had a relaxing day at the beach. The sound of the waves was so calming.", lastUpdated: Date().addingTimeInterval(-250000))
    ]
    
    notes.forEach { note in
        container.mainContext.insert(note)
    }
    
    return ContentView()
        .modelContainer(container)
}
