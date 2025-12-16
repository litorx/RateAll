//
//  SplashView.swift.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    @State private var scale: CGFloat = 0.3
    @State private var opacity: Double = 0.0
    @State private var fadeOut: Double = 1.0
    
    var body: some View {
        ZStack{
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()
        
        if isActive {
            OnboardingView()
                .transition(
                    .opacity
                    .animation(.easeIn(duration: 1.0))
                )
        }
        else{
            ZStack {
                AppColors.dark.backgroundGradient
                    .ignoresSafeArea()
                VStack{
                    Image("NoBackIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .scaleEffect(scale)
                        .opacity(opacity)
                    
                    Text("splashTitleText")
                        .font(.displayLarge)
                        .bold()
                        .foregroundColor(AppColors.dark.textPrimary)
                        .scaleEffect(scale)
                        .opacity(opacity)
                    
                    Text("splashBodyText")
                        .font(.headlineLarge)
                        .bold()
                        .foregroundColor(AppColors.dark.textPrimary)
                        .scaleEffect(scale)
                        .opacity(opacity)
                    
                    
                }
                .opacity(fadeOut)
            }
            .transition(.opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    scale = 1.0
                    opacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        fadeOut = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isActive = true
                    }
                }
            }
                
            }
        }
    }
}

#Preview {
    SplashView()
}
