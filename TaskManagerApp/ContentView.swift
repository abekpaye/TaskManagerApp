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

    @State private var showAddTaskSheet = false
    @State private var selectedFilter = "All"

    private let filters = ["All", "Active", "Completed"]

    private var filteredTasks: [ToDoItem] {
        switch selectedFilter {
        case "Active":
            return tasks.filter { !$0.isCompleted }
        case "Completed":
            return tasks.filter { $0.isCompleted }
        default:
            return tasks
        }
    }

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

                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                if filteredTasks.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "tray")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("No tasks yet")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                } else {

                    List {
                        ForEach($tasks) { $task in
                            if shouldShow(task) {
                                taskRow(task: $task)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                tasks.remove(atOffsets: indexSet)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTaskSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTaskSheet) {
                AddTaskView { newTask in
                    withAnimation {
                        tasks.append(newTask)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func taskRow(task: Binding<ToDoItem>) -> some View {
        HStack(spacing: 12) {

            Image(systemName: task.wrappedValue.isCompleted
                  ? "checkmark.circle.fill"
                  : "circle")
                .foregroundColor(task.wrappedValue.isCompleted ? .green : .gray)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        task.wrappedValue.isCompleted.toggle()
                    }
                }

            Text(task.wrappedValue.title)
                .strikethrough(task.wrappedValue.isCompleted)
                .foregroundColor(task.wrappedValue.isCompleted ? .secondary : .primary)

            Spacer()

            Text(task.wrappedValue.priority)
                .font(.caption)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(priorityColor(task.wrappedValue.priority))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(16)
        .shadow(radius: 2)
    }

    private func shouldShow(_ task: ToDoItem) -> Bool {
        switch selectedFilter {
        case "Active":
            return !task.isCompleted
        case "Completed":
            return task.isCompleted
        default:
            return true
        }
    }

    private func priorityColor(_ priority: String) -> Color {
        switch priority {
        case "High":
            return .red
        case "Medium":
            return .orange
        default:
            return .blue
        }
    }
}

#Preview {
    ContentView()
}
