//
//  ToDoItem.swift
//  TaskManagerApp
//
//  Created by Aida on 16.01.2026.
//

import Foundation

struct ToDoItem: Identifiable {
    let id = UUID()
    var title: String
    var priority: String
    var isCompleted: Bool
}
