//
//  TodoListView.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var viewModel = TodoListViewModel()
    
    let todoList = [
        Todo(
            id: UUID().uuidString,
            title: "Travel",
            description: "Go back to Batam",
            isCompleted: false
        ),
        Todo(
            id: UUID().uuidString,
            title: "Code",
            description: "Finish project to become a senior",
            isCompleted: false
        ),
    ]
    
    var body: some View {
        NavigationStack {
            List(todoList) { todo in
                HStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill")
                    
                    VStack(alignment: .leading) {
                        Text(todo.title)
                            .font(.headline)
                        
                        Text(todo.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem {
                    NavigationLink(
                        destination: Text("Add Todo"),
                        isActive: $viewModel.isAddingTodo
                    ) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    TodoListView()
}
