//
//  SignInView.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 13/07/2024.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Text("Sign In")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 24)
                
                TextField(
                    "Email",
                    text: $viewModel.email
                )
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 16)
                .autocapitalization(.none)
                
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16)
                .autocapitalization(.none)
                
                Button {
                    viewModel.signIn()
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .navigationDestination(
                    isPresented: $viewModel.isSignInSuccess,
                    destination: {
                        TodoListView()
                    }
                )
            }
            .padding()
        }
    }
}

#Preview {
    SignInView()
}
