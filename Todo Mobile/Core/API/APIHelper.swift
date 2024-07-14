//
//  APIHelper.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation

protocol APIHelper {
    static func getRequest<T: Codable>(endpoint: String, queries: [String: String]?) async throws -> APIResponse<T>
    static func postRequest<T: Codable, V: Codable>(endpoint: String, body: V) async throws -> APIResponse<T>
    static func patchRequest<T: Codable>(endpoint: String, id: String, body: T) async throws -> APIResponse<String>
    static func deleteRequest(endpoint: String, id: String) async throws -> APIResponse<String>
}

class APIHelperImplementation: APIHelper {
    
    static func getRequest<T: Codable>(
        endpoint: String,
        queries: [String: String]? = nil
    ) async throws -> APIResponse<T> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<T>>().makeRequest(
                path: endpoint,
                method: .get,
                body: String?.none,
                queries: queries,
                decodable: { _ in },
                completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data!)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    static func postRequest<T: Codable, V: Codable>(
        endpoint: String,
        body: V
    ) async throws -> APIResponse<T> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<T>>().makeRequest(
                path: endpoint,
                method: .post,
                body: body,
                decodable: { _ in },
                completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data!)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    static func patchRequest<T: Codable>(
        endpoint: String,
        id: String,
        body: T
    ) async throws -> APIResponse<String> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<String>>().makeRequest(
                path: "\(endpoint)/\(id)",
                method: .patch,
                body: body,
                decodable: {_ in},
                completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data!)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    static func deleteRequest(
        endpoint: String,
        id: String
    ) async throws -> APIResponse<String> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<String>>().makeRequest(
                path: "\(endpoint)/\(id)",
                method: .delete,
                body: String?.none,
                decodable: {_ in},
                completion: { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data!)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
}
