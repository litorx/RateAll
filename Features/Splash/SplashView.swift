//
//  SplashView.swift.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import Foundation
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
            .ignoresSafeArea()
            HStack {
                CircleWithGradient()
                CircleWithGradient()
            }

        }
    }
}

@ViewBuilder
func CircleWithGradient() -> some View {
    ZStack{
        Circle()
            .fill(
                AppColors.dark.cardsGradient
            )
            .frame(width: 150, height: 150)
        VStack {
            Text("Splash")
                .foregroundStyle(AppColors.dark.accent1)
            Text("Splash")
                .foregroundStyle(AppColors.dark.accent2)
            Text("Splash")
                .foregroundStyle(AppColors.dark.textPrimary)
            Text("Splash")
                .foregroundStyle(AppColors.dark.textSecondary)
        }
    }
}

#Preview {
    SplashView()
}
