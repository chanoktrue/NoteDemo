//
//  NoteApp.swift
//  Note
//
//  Created by Thongchai Subsaidee on 12/11/2024.
//

import SwiftUI
import SwiftData

@main
struct NoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Note.self])
        }
    }
}
