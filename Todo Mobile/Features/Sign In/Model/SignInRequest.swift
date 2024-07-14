//
//  SignInRequest.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 13/07/2024.
//

import Foundation

class SignInRequest: Codable {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
