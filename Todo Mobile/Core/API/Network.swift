//
//  Network.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation
import Request
import Defaults

struct Network<V: Decodable> {
    
    func makeRequest<T: Codable>(
        path: String,
        method: MethodType,
        type: MediaType = .json,
        body: T? = nil,
        queries: [String: String]? = nil,
        form: T? = nil,
        timeout: TimeInterval? = nil,
        decodable: @escaping (V?) -> Void,
        completion: @escaping (Result<V?, Error>) -> Void
    ) {
        let serverURL = "http://localhost:1724/"
        
        Request {
            Url(serverURL + path)
            Method(method)
            Timeout(timeout ?? 30)
            Header.ContentType(type)
            Header.CacheControl(.noCache)

            if let token = Defaults[.token] {
                Header.Authorization(.bearer(token))
            }
            
            if let body {
                Body(body)
            }
            
            if let queries {
                Query(queries)
            }
        }
        .onData { responseData in
            if responseData.isEmpty {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    do {
                        let data = try JSONDecoder().decode(V.self, from: responseData)
                        
                        DispatchQueue.main.async {
                            _ = decodable(data)
                            completion(.success(data))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
        .onError { error in
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
        .call()
    }
}

public struct Timeout: RequestParam {
    private let timeout: TimeInterval
    
    public init(_ timeout: TimeInterval) {
        self.timeout = timeout
    }

    public func buildParam(_ request: inout URLRequest) {
        request.timeoutInterval = timeout
    }
}
