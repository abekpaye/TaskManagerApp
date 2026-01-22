import SwiftUI

struct AddTaskView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var priority = "Medium"

    let priorities = ["Low", "Medium", "High"]
    let onSave: (ToDoItem) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $title)

                Picker("Priority", selection: $priority) {
                    ForEach(priorities, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(
                            ToDoItem(
                                title: title,
                                priority: priority,
                                isCompleted: false
                            )
                        )
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
