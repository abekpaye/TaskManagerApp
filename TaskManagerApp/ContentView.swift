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
                
                VStack(alignment: .leading, spacing: 4) {
                        Text("Task Manager")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Active tasks: \(tasks.filter { !$0.isCompleted }.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                VStack(spacing: 12) {
                    ForEach(tasks) { task in
                        HStack(spacing: 12) {

                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)

                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundColor(task.isCompleted ? .secondary : .primary)

                            Spacer()

                            Text(task.priority)
                                .font(.caption)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(.thinMaterial)
                                .cornerRadius(8)
                        }
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
            .navigationTitle("My Tasks")
        }
    }
}

#Preview {
    ContentView()
}
