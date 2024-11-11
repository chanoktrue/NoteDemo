//
//  ContentView.swift
//  Note
//
//  Created by Thongchai Subsaidee on 12/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var notes: [Note]
    
    var body: some View {
        NavigationStack {
            List {
                let pinnedNotes = notes.filter({$0.isPinned})
                if !pinnedNotes.isEmpty {
                    Section("Pinned Notes"){
                        ForEach(pinnedNotes) { pinnedNote in
                            VStack(alignment: .leading) {
                                Text(pinnedNote.title)
                                    .font(.headline)
                                Text(pinnedNote.lastUpdated
                                    .formatted(date: .numeric, time: .shortened))
                                .font(.subheadline)
                            }
                        }
                    }
                }
                
                
                let unpinnedNotes = notes.filter({!$0.isPinned})
                if !unpinnedNotes.isEmpty {
                    Section("Unpinned Notes"){
                        ForEach(unpinnedNotes) { unpinnedNote in
                            VStack(alignment: .leading) {
                                Text(unpinnedNote.title)
                                    .font(.headline)
                                Text(unpinnedNote.lastUpdated
                                    .formatted(date: .numeric, time: .shortened))
                                .font(.subheadline)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Note")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Text("\(notes.count) Note")
                        .font(.footnote)
                    Spacer()
                    Button("Create note", systemImage: "square.and.pencil"){
                        
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Note.self, configurations: config)
    
    let notes: [Note] = [
        Note(
            title: "Epiphany",
            isPinned: false,
            content: "Today I the importance of taking regular breaks toboost productivity.",
            lastUpdated: Date() .addingTimeInterval(-500000)
        ),
        Note (
            title: "Euphoria",
            isPinned: true,
            content : "wonderful time at the park with friends. The weather was perfect!",
            lastUpdated: Date() .addingTimeInterval(-300000)
        ),
        Note (
            title: "Reverie",
            isPinned: false,
            content: "I spent the afternoon daydreaming about my next vacation destination.",
            lastUpdated:Date ().addingTimeInterval(-700000)
        ),
        Note(
            title: "Solitude",
            isPinned: true,
            content: "Enjoyed a peaceful evening reading my favorite book in solitude.",
            lastUpdated: Date() .addingTimeInterval(-200000)
        ),
        Note(
            title: "Aurora",
            isPinned: false,
            content: "Woke up early to catch the sunrise. The colors were absolutely breathtaking.",
            lastUpdated: Date() .addingTimeInterval(-800000)
        )
    ]
    
//    notes.forEach { note in
//        print(note)
//       }
//    
    ContentView()
        .modelContainer(container)
}

