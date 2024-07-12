//
//  APIHelper.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation

protocol APIHelper {
    func getRequest<T: Codable>(endpoint: String) async throws -> APIResponse<T>
    func postRequest<T: Codable>(endpoint: String, body: (any Encodable)?) async throws -> APIResponse<T>
    func patchRequest(endpoint: String, id: String, body: (any Encodable)?) async throws -> APIResponse<String>
    func deleteRequest(endpoint: String, id: String) async throws -> APIResponse<String>
}

class APIHelperImplementation: APIHelper {
    
    func getRequest<T: Codable>(endpoint: String) async throws -> APIResponse<T> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<T>>().makeRequest(
                path: endpoint,
                method: .get,
                body: String?.none,
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
    
    func postRequest<T: Codable>(
        endpoint: String,
        body: (any Encodable)
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
    
    func patchRequest(
        endpoint: String,
        id: String,
        body: (any Encodable)?
    ) async throws -> APIResponse<String> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<String>>().makeRequest(
                path: endpoint,
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
    
    func deleteRequest(
        endpoint: String,
        id: String
    ) async throws -> APIResponse<String> {
        try await withCheckedThrowingContinuation { continuation in
            Network<APIResponse<String>>().makeRequest(
                path: endpoint,
                method: .patch,
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
