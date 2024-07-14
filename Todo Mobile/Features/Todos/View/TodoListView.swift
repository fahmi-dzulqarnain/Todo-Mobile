//
//  TodoListView.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var viewModel = TodoListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.todoList) { todo in
                        HStack(spacing: 16) {
                            let todoImage = todo.isCompleted ? "checkmark.circle.fill" : "circle"
                            
                            Image(systemName: todoImage)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(
                                    todo.isCompleted
                                    ? .green
                                    : .gray
                                )
                                .onTapGesture {
                                    viewModel.toggleTodo(todo: todo)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .font(.headline)
                                
                                if !todo.description.isEmpty {
                                    Text(todo.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .onLongPressGesture {
                            viewModel.updatingTodo(todo: todo)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeTodo(indexSet: indexSet)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Title")
                        .font(.headline)
                    
                    TextField(
                        "Title",
                        text: $viewModel.title
                    )
                    .textFieldStyle(.roundedBorder)
                    
                    Text("Description")
                        .font(.headline)
                    
                    TextField(
                        "Description",
                        text: $viewModel.description
                    )
                    .textFieldStyle(.roundedBorder)
                    
                    HStack {
                        Spacer()
                        
                        let buttonTitle = viewModel.isUpdatingTodo 
                            ? "Update Todo"
                            : "Add New Todo"
                        
                        Button(buttonTitle) {
                            if viewModel.isUpdatingTodo {
                                viewModel.updateTodo()
                            } else {
                                viewModel.addTodo()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.top)
                }
                .padding(.horizontal, 12)
                .padding(16)
            }
            .navigationTitle("Todo List")
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    TodoListView()
}
