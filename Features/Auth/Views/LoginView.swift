//
//  LoginView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 16/12/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authState: AuthState
    
    var body: some View {
        LoginViewContent(authState: authState)
    }
}

private struct LoginViewContent: View {
    @StateObject private var googleAuth: GoogleAuthViewModel
    @StateObject private var appleAuth: AppleAuthViewModel
    
    init(authState: AuthState) {
        _googleAuth = StateObject(wrappedValue: GoogleAuthViewModel(authState: authState))
        _appleAuth = StateObject(wrappedValue: AppleAuthViewModel(authState: authState))
    }
    
    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()
            
            VStack {
                LoginHeader()
                

                Button(action: {
                    Task {
                        await googleAuth.signInWithGoogle()
                    }
                }) {
                    HStack(spacing: 12) {
                        if googleAuth.isLoading {
                            ProgressView()
                                .tint(AppColors.dark.textPrimary)
                        } else {
                            Image("google_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("loginGoogleText")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .font(.headlineMedium)
                .foregroundStyle(AppColors.dark.textPrimary)
                .padding(.vertical, 16)
                .background(AppColors.dark.accent1)
                .cornerRadius(24)
                .padding(.horizontal, 32)
                .disabled(googleAuth.isLoading || appleAuth.isLoading)
                
                DividerOrView()
                    .padding(.vertical, 16)
                
    
                Button(action: {
                    Task {
                        await appleAuth.signInWithApple()
                    }
                }) {
                    HStack(spacing: 12) {
                        if appleAuth.isLoading {
                            ProgressView()
                                .tint(AppColors.dark.textPrimary)
                        } else {
                            Image(systemName: "apple.logo")
                                .font(.system(size: 24))
                            
                            Text("loginAppleText")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .font(.headlineMedium)
                .foregroundStyle(AppColors.dark.textPrimary)
                .padding(.vertical, 16)
                .background(AppColors.dark.cardEnd)
                .cornerRadius(24)
                .padding(.horizontal, 32)
                .disabled(googleAuth.isLoading || appleAuth.isLoading)
                
           
                if let error = googleAuth.errorMessage ?? appleAuth.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.top, 16)
                }
            }
        }
    }
}

struct LoginHeader: View {
    var body: some View {
        VStack {
            Image("LoginIlustration1")
                .resizable()
                .scaledToFit()
                .frame(width: 390, height: 260)
            
            Text("Vamos começar?")
                .foregroundStyle(AppColors.dark.textPrimary)
                .font(Font.displayLarge)
            
            Text("Faça seu login com sua conta Google ou Apple")
                .foregroundStyle(AppColors.dark.textSecondary)
                .font(Font.headlineMedium)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
        }
    }
}


struct DividerOrView: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.5))
            
            Text("loginDividerText")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthState())
}
