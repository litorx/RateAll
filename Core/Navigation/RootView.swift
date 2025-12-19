//
//   RootView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//


import SwiftUI


struct RootView: View {
    @EnvironmentObject private var authState: AuthState
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    

    @State private var isShowingSplash = true
    
    var body: some View {
        ZStack {
           
            if isShowingSplash {
                SplashView(onFinish: {
                 
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isShowingSplash = false
                    }
                })
               
                .transition(.opacity)
                .zIndex(3)
            }
            
          
            else if !hasSeenOnboarding {
                OnboardingView(onFinish: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        hasSeenOnboarding = true
                    }
                })
                .transition(.opacity)
                .zIndex(2)
            }
            
            else {
                
                Group {
                    if authState.isAuthenticated {
                        DashboardView()
                    } else {
                        LoginView()
                    }
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.7), value: isShowingSplash)
        .animation(.easeInOut(duration: 0.8), value: hasSeenOnboarding)
        .animation(.easeInOut(duration: 0.7), value: authState.isAuthenticated)
    }
}
