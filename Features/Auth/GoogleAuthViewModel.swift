//
//  GoogleAuth.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 18/12/25.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@MainActor
final class GoogleAuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authState: AuthState
    

    init(authState: AuthState) {
        self.authState = authState
    }
    
    func signInWithGoogle() async {
        isLoading = true
        errorMessage = nil
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            errorMessage = "Client ID não encontrado"
            isLoading = false
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            errorMessage = "Não foi possível obter a view controller"
            isLoading = false
            return
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            guard let idToken = result.user.idToken?.tokenString else {
                errorMessage = "Token inválido"
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            let authResult = try await Auth.auth().signIn(with: credential)
            
            // ✅ Notifica o AuthState
            authState.signIn(user: authResult.user)
            
        } catch {
            errorMessage = "Erro ao fazer login: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func signOut() {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            authState.signOut()
        } catch {
            errorMessage = "Erro ao fazer logout: \(error.localizedDescription)"
        }
    }
}
