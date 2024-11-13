//
//  CreateNoteView.swift
//  Note
//
//  Created by Thongchai Subsaidee on 13/11/2024.
//

import SwiftUI

struct CreateNoteView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var isPenned: Bool = false
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
           Form {
                Section {
                   TextField("Title", text: $title)
                    Toggle("Pinned this Note?", isOn: $isPenned)
               }
               Section {
                   TextEditor(text: $content)
                       .frame(height: 160)
               }
            }
           .navigationTitle("Creae Note")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItemGroup(placement: .topBarLeading) {
                   Button("Cancel") {
                       dismiss()
                   }
               }
               ToolbarItemGroup(placement: .topBarTrailing) {
                   Button("Create") {
                       let note = Note(title: title, isPinned: isPenned, content: content, lastUpdated: Date())
                       modelContext.insert(note)
                       dismiss()
                   }
               }
           }
            
           
        }
    }
}

#Preview {
    CreateNoteView()
}
