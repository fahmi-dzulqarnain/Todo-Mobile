//
//  TodoAPIService.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 13/07/2024.
//

import Foundation

protocol TodoAPIService {
    static func getTodos(
        limit: Int,
        page: Int,
        keyword: String
    ) async throws -> APIResponse<DataResponse<Todo>>
    static func addTodo(todo: Todo) async throws -> APIResponse<Todo>
    static func updateTodo(todo: Todo) async throws -> APIResponse<String>
    static func deleteTodoById(id: String) async throws -> APIResponse<String>
}

class TodoAPIServiceImplementation: TodoAPIService {
    
    static let endpoint: String = "todo"
    
    static func getTodos(
        limit: Int = 10,
        page: Int = 1,
        keyword: String = ""
    ) async throws -> APIResponse<DataResponse<Todo>> {
        return try await APIHelperImplementation.getRequest(
            endpoint: endpoint,
            queries: [
                "limit": String(limit),
                "page": String(page),
                "keyword": keyword
            ]
        )
    }
    
    static func addTodo(todo: Todo) async throws -> APIResponse<Todo> {
        return try await APIHelperImplementation.postRequest(
            endpoint: endpoint,
            body: todo
        )
    }
    
    static func updateTodo(todo: Todo) async throws -> APIResponse<String> {
        return try await APIHelperImplementation.patchRequest(
            endpoint: endpoint,
            id: todo.id,
            body: todo
        )
    }
    
    static func deleteTodoById(id: String) async throws -> APIResponse<String> {
        return try await APIHelperImplementation.deleteRequest(
            endpoint: endpoint,
            id: id
        )
    }
}
