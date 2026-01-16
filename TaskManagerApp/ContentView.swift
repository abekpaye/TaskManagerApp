//
//  ContentView.swift
//  TaskManagerApp
//
//  Created by Aida on 16.01.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [ToDoItem] = [
        ToDoItem(title: "Learn SwiftUI", priority: "High", isCompleted: false),
        ToDoItem(title: "Do Assignment 6", priority: "Medium", isCompleted: false)
    ]
    
    @State private var showAddTaskSheet: Bool = false
    @State private var selectedFilter: String = "All"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Text("Tasks count: \(tasks.count)")
                
                Button("Add Task") {
                    tasks.append(
                        ToDoItem(title: "New Task", priority: "Low", isCompleted: false)
                    )
                }
                
            }
            .padding()
            .navigationTitle("My Tasks")
        }
    }
}

#Preview {
    ContentView()
}
