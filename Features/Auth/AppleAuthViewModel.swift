//
//  AppleAuth.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 18/12/25.
//

import SwiftUI
import Combine
import FirebaseAuth
import AuthenticationServices
import CryptoKit

@MainActor
final class AppleAuthViewModel: NSObject, ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentNonce: String?
    private let authState: AuthState
    
    // ✅ Adicione este inicializador
    init(authState: AuthState) {
        self.authState = authState
        super.init()
    }
    
    func signInWithApple() {
        isLoading = true
        errorMessage = nil
        
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            authState.signOut()
        } catch {
            errorMessage = "Erro ao fazer logout: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Helpers
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        
        if errorCode != errSecSuccess {
            fatalError("Erro ao gerar nonce")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleIDToken = appleIDCredential.identityToken,
              let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            errorMessage = "Erro ao obter credenciais"
            isLoading = false
            return
        }
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: idTokenString,
            rawNonce: nonce
        )
        
        Task {
            do {
                let authResult = try await Auth.auth().signIn(with: credential)
                
                // ✅ Notifica o AuthState
                authState.signIn(user: authResult.user)
                
            } catch {
                errorMessage = "Erro ao autenticar: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        errorMessage = "Erro no login: \(error.localizedDescription)"
        isLoading = false
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("Não foi possível obter a window")
        }
        return window
    }
}
