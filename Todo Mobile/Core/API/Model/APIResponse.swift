//
//  APIResponse.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let message: String
    let statusCode: Int?
    let error: String?
    let data: DataResponse<T>?
}
