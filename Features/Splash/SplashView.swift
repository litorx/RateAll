//
//  SplashView.swift.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void
    
    @State private var scale: CGFloat = 0.3
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()


            splashContent
                .onAppear {

                    withAnimation(.easeInOut(duration: 1.0)) {
                        scale = 1.0
                        opacity = 1.0
                    }


                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
  
                        withAnimation {
                            onFinish()
                        }
                    }
                }
        }
    }

    var splashContent: some View {
        VStack {
            Image("NoBackIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 150)
                .scaleEffect(scale)
                .opacity(opacity)
            
            Text("splashTitleText")
                .font(.largeTitle)
                .bold()
                .foregroundColor(AppColors.dark.textPrimary)
                .scaleEffect(scale)
                .opacity(opacity)
            
            Text("splashBodyText")
                .font(.headline)
                .bold()
                .foregroundColor(AppColors.dark.textPrimary)
                .scaleEffect(scale)
                .opacity(opacity)
        }
    }
}

