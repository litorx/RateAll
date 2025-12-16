//
//  OnboardingView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage: Int = 0
    
    let pages: [(image: String, title: LocalizedStringKey, textBody: LocalizedStringKey)] = [
        (image: "OnboardingIlustration1", title: "onboardingTextTitle1", textBody: "onboardingTextBody1"),
        (image: "OnboardingIlustration2", title: "onboardingTextTitle2", textBody: "onboardingTextBody2"),
        (image: "OnboardingIlustration3", title: "onboardingTextTitle3", textBody: "onboardingTextBody3")
    ]

    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()
            VStack{
                HStack(spacing: 9) {
                    ForEach(0..<pages.count, id: \.self) { pageIndex in
                        Capsule()
                            .fill(pageIndex == currentPage ? AppColors.dark.accent1 : AppColors.dark.progressBarBackground)
                            .frame(width: pageIndex == currentPage ? 95 : 70, height: 7)
                            .animation(.easeInOut(duration: 0.28), value: currentPage)
                    }
                }
                .frame(height: 40)
                .padding(.top, 20)
                
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        VStack(spacing: 0) {
                            
                            Spacer(minLength:75)
                            
                            Image(pages[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 365, height: 250)
                                .cornerRadius(70)
                            
                            Spacer(minLength: 10)
                            
                            
                            Text(pages[index].title)
                                .font(Font.displayLarge)
                                .foregroundColor(AppColors.dark.textPrimary)
                                .multilineTextAlignment(.center)
                                .frame(minHeight: 30)
                                .padding(.horizontal, 16)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            
                            Text(pages[index].textBody)
                                .font(Font.bodyLarge)
                                .foregroundColor(AppColors.dark.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .frame(minHeight: 90, alignment: .center)
                            
                            
                            
                            
                            Spacer(minLength: 30)
                            
                            
                            VStack(spacing: 16) {
                                Button(action: {
                                    if currentPage < pages.count - 1 {
                                        withAnimation {
                                            currentPage += 1
                                        }
                                    }
                                }) {
                                    Text("onboardingButtonContinue")
                                        .foregroundColor(AppColors.dark.textPrimary)
                                        .font(Font.headlineMedium)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 18)
                                        .background(AppColors.dark.accent1)
                                        .cornerRadius(30)
                                }
                                
                                Button(action: {
                                    if currentPage > 0 {
                                        withAnimation {
                                            currentPage -= 1
                                        }
                                    }
                                }) {
                                    Text("onboardingButtonBack")
                                        .foregroundColor(AppColors.dark.textPrimary)
                                        .font(Font.bodyMedium)
                                        .frame(height: 44)
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 50)
                        }
                        .background(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}

#Preview {
    OnboardingView()
}
