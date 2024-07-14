//
//  Todo.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Foundation

struct Todo: Codable, Identifiable {
    let id: String
    var title: String
    var description: String
    var isCompleted: Bool
}
