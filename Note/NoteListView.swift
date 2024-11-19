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
    
    @Binding var isShowCreateNote: Bool
    
    init(sort: SortDescriptor<Note>, searchKeyworkd: String, isShowCreateNote: Binding<Bool>  ) {
        _notes = Query(filter: #Predicate{
            if searchKeyworkd.isEmpty {
                return true
            }else {
                return $0.title.localizedStandardContains(searchKeyworkd) ||
                $0.content.localizedStandardContains(searchKeyworkd)
            }
            
        }, sort: [sort])
        
        _isShowCreateNote = isShowCreateNote
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
        .overlay {
            if notes.isEmpty {
                ContentUnavailableView {
                    Label("No Notes", systemImage: "note.text")
                } description: {
                    Text("All of your notes will displaed here.")
                } actions: {
                    Button("Create new note") {
                        isShowCreateNote.toggle()
                    }
                }

            }
        }
    }
}

#Preview {
    @Previewable @State var isShow = false
    return NoteListView(sort: SortDescriptor(\Note.title), searchKeyworkd: "", isShowCreateNote: $isShow)
}
