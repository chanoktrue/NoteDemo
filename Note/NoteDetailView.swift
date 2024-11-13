//
//  NoteDetailView.swift
//  Note
//
//  Created by Thongchai Subsaidee on 13/11/2024.
//

import SwiftUI
//import SwiftData

struct NoteDetailView: View {
    
    @Bindable var note: Note
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading , spacing: 4) {
                HStack {
                    Spacer()
                    Text(note.lastUpdated.formatted(date: .abbreviated, time: .shortened))
                        .font(.footnote)
                    Spacer()
                }
                TextEditor(text: $note.content)
                    .font(.body)
            }
            .padding()
            .navigationTitle(note.title)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: note.content) { oldValue, newValue in
                note.lastUpdated = Date()
            }
        }
    }
}

#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Note.self, configurations: config)

    let note = Note(title: "Test Note", isPinned: false, content: "Hello World", lastUpdated: Date())
    
    return NoteDetailView(note: note)
}

