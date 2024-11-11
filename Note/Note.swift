//
//  Note.swift
//  Note
//
//  Created by Thongchai Subsaidee on 12/11/2024.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var isPinned: Bool
    var content: String
    var lastUpdated: Date
    
    init(title: String, isPinned: Bool, content: String, lastUpdated: Date) {
        self.title = title
        self.isPinned = isPinned
        self.content = content
        self.lastUpdated = lastUpdated
    }
}
