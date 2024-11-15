//
//  NoteListView.swift
//  Note
//
//  Created by Thongchai Subsaidee on 15/11/2024.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var notes: [Note]
    
    init(sort: SortDescriptor<Note>) {
        _notes = Query(sort: [sort])
    }
    
    
    var body: some View {
        List {
            let pinnedNotes = notes.filter({$0.isPinned})
            if !pinnedNotes.isEmpty {
                Section("Pinned Notes"){
                    ForEach(pinnedNotes) { pinnedNote in
                        NavigationLink(destination: NoteDetailView(note: pinnedNote)) {
                            VStack(alignment: .leading) {
                                Text(pinnedNote.title)
                                    .font(.headline)
                                Text(pinnedNote.lastUpdated
                                    .formatted(date: .numeric, time: .shortened))
                                .font(.subheadline)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("Delete", systemImage: "trash.fill", role: .destructive) {
                                modelContext.delete(pinnedNote)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                pinnedNote.isPinned.toggle()
                            } label: {
                                if pinnedNote.isPinned {
                                    Image(systemName: "pin.slash.fill")
                                }else {
                                    Image(systemName: "pin.fill")
                                }
                            }
                        }
                    }
                }
            }
            
            
            let unpinnedNotes = notes.filter({!$0.isPinned})
            if !unpinnedNotes.isEmpty {
                Section("Unpinned Notes"){
                    ForEach(unpinnedNotes) { unpinnedNote in
                        NavigationLink(destination: NoteDetailView(note: unpinnedNote)) {
                            VStack(alignment: .leading) {
                                Text(unpinnedNote.title)
                                    .font(.headline)
                                Text(unpinnedNote.lastUpdated
                                    .formatted(date: .numeric, time: .shortened))
                                .font(.subheadline)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("Delete", systemImage: "trash.fill", role: .destructive) {
                                modelContext.delete(unpinnedNote)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                unpinnedNote.isPinned.toggle()
                            } label: {
                                if unpinnedNote.isPinned {
                                    Image(systemName: "pin.slash.fill")
                                } else {
                                    Image(systemName: "pin.fill")
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    NoteListView(sort: SortDescriptor(\Note.title))
}
