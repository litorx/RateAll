//
//  ContentView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import SwiftUI


import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()

            VStack {

                Spacer().frame(height: 10)
                HStack(spacing: 9) {
                    Capsule()
                        .fill(AppColors.dark.accent1)
                        .frame(width: 85, height: 7)

                    ForEach(0..<3) { _ in
                        Capsule()
                            .fill(AppColors.dark.progressBarBackground)
                            .frame(width: 65, height: 6)
                    }
                }
                .padding(.top, 10)

                Spacer().frame(height: 110)


                Image("OnboardingIlustration1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 365, maxHeight: 250)
                    .cornerRadius(70)


                Spacer().frame(height: 20)

                
                Text("onboardingTextTitle1")
                    .font(Font.displayLarge)
                    .foregroundColor(AppColors.dark.textPrimary)
                    .multilineTextAlignment(.center)
 
                Text("onboardingTextBody1")
                .font(Font.bodyLarge)
                .foregroundColor(AppColors.dark.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

                Spacer().frame(height: 30)


                VStack {
                    Button(action: {
           
                    }) {
                        Text("Continuar")
                            .foregroundColor(AppColors.dark.textPrimary)
                            .font(Font.headlineMedium)
                            .padding(.horizontal, 140)
                            .padding(.vertical, 18)
                            .background(AppColors.dark.accent1)
                            .cornerRadius(30)
                    }
                    
                    Spacer().frame(height: 16)
                    
                    Button(action: {
       
                    }) {
                        Text("Voltar")
                            .foregroundColor(AppColors.dark.textPrimary)
                            .font(Font.bodyMedium)
                    }

                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    ContentView()
}
