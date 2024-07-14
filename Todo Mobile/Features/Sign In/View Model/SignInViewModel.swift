//
//  SignInViewModel.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 13/07/2024.
//

import Defaults
import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSignInSuccess: Bool = false
    
    func signIn() {
        Task {
            do {
                let response: APIResponse<SignInResponse> = try await APIHelperImplementation.postRequest(
                    endpoint: "auth/signIn",
                    body: SignInRequest(email: email, password: password)
                )
                
                if let user = response.data {
                    Defaults[.token] = user.accessToken
                    
                    await MainActor.run {
                        self.email = ""
                        self.password = ""
                        self.isSignInSuccess = true
                    }
                } else {
                    print("Sign In Failed")
                }
            } catch {
                print("Sign In Failed: \(error)")
            }
        }
    }
}
