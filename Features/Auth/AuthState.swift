//
//  AuthState.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 18/12/25.
//
import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    init() {
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        if let user = Auth.auth().currentUser {
            currentUser = user
            isAuthenticated = true
        }
    }
    
    func signIn(user: User) {
        currentUser = user
        isAuthenticated = true
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
    }
}
