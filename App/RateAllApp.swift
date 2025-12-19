//
//  RateAllApp.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import SwiftUI
import FirebaseCore

@main
struct RateAllApp: App {
    @StateObject private var authState = AuthState()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppColors.dark.backgroundGradient
                    .ignoresSafeArea()
                RootView()
                    .environmentObject(authState)
            }
        }
    }
}
