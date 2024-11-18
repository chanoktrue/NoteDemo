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
    
    @State var isShowingInvalidInputAlert: Bool = false
    
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
           .navigationTitle("Create Note")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItemGroup(placement: .topBarLeading) {
                   Button("Cancel") {
                       dismiss()
                   }
               }
               ToolbarItemGroup(placement: .topBarTrailing) {
                   Button("Create") {
                       
                       if !title.isEmpty && !content.isEmpty {
                           let note = Note(title: title, isPinned: isPenned, content: content, lastUpdated: Date())
                           modelContext.insert(note)
                           dismiss()
                       }else{
                           isShowingInvalidInputAlert.toggle()
                       }
                   }
               }
           }
           .alert("Invalid Input", isPresented: $isShowingInvalidInputAlert) {
               Button("OK") {
                   
               }
           }message: {
               Text("Please check your input and try again")
           }
           
        }
    }
}

#Preview {
    CreateNoteView()
}
