//
//  TodoListViewModel.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Defaults
import Foundation
import Request

class TodoListViewModel: ObservableObject {
    @Published var todoID = ""
    @Published var title = ""
    @Published var description = ""
    @Published var isSelectedTodoCompleted = false
    @Published var isUpdatingTodo = false
    @Published var todoList: [Todo] = []
    
    init() {
        Task {
            await fetchTodos()
        }
    }
    
    func fetchTodos() async {
        do {
            let todos: APIResponse<DataResponse<Todo>> = try await TodoAPIServiceImplementation.getTodos()
            self.todoList = todos.data?.dataList ?? []
        } catch {
            print(error)
            
            if let error = error as? RequestError {
                if error.statusCode == 401 {
                    Defaults[.token] = nil
                }
            }
        }
    }
    
    func addTodo() {
        let todo = Todo(
            id: UUID().uuidString,
            title: title,
            description: description,
            isCompleted: false
        )
        
        Task {
            do {
                let response: APIResponse<Todo> = try await TodoAPIServiceImplementation.addTodo(todo: todo)
                
                if let todo = response.data {
                
                    await MainActor.run {
                        todoList.append(todo)
                        resetForm()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func toggleTodo(todo: Todo) {
        updatingTodo(todo: todo)
        isSelectedTodoCompleted.toggle()
        updateTodo()
    }
    
    func removeTodo(indexSet: IndexSet) {
        indexSet.forEach { index in
            let todo = todoList[index]
            Task {
                do {
                    let response: APIResponse<String> = try await TodoAPIServiceImplementation.deleteTodoById(id: todo.id)
                    
                    if let removedTodoID = response.data {
                        print(removedTodoID)
                        await MainActor.run {
                            todoList.remove(atOffsets: indexSet)
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func updatingTodo(todo: Todo) {
        todoID = todo.id
        title = todo.title
        description = todo.description
        isSelectedTodoCompleted = todo.isCompleted
        isUpdatingTodo = true
    }
    
    func updateTodo() {
        Task {
            do {
                let todo = Todo(
                    id: todoID,
                    title: title,
                    description: description,
                    isCompleted: isSelectedTodoCompleted
                )
                
                let response: APIResponse<String> = try await TodoAPIServiceImplementation.updateTodo(todo: todo)
                
                if let updatedTodoID = response.data {
                    guard let index = todoList.firstIndex(where: {
                        $0.id == updatedTodoID
                    }) else {
                        return
                    }
                    
                    await MainActor.run {
                        todoList[index].title = title
                        todoList[index].description = description
                        todoList[index].isCompleted = isSelectedTodoCompleted
                        
                        resetForm()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func resetForm() {
        todoID = ""
        title = ""
        description = ""
        isUpdatingTodo = false
    }
}
