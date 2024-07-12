//
//  Todo.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation

struct Todo: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let isCompleted: Bool
}
