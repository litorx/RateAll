//
//  SearchView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    var body: some View {
        ZStack(alignment: .top) {
            AppColors.dark.cardsGradient
                .frame(height: 130)
                .frame(maxWidth: .infinity)
                .overlay(
                    Rectangle()
                        .stroke(AppColors.dark.textSecondary.opacity(0.4), lineWidth: 0.5)
                )
                .ignoresSafeArea(edges: .top)
            HStack {
                Button (action: {}){
                    ZStack {
                        AppColors.dark.searchGradient
                            .frame(width: 300, height: 45)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(AppColors.dark.textSecondary.opacity(0.5), lineWidth: 2)
                            )
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(AppColors.dark.textPrimary)
                            .font(Font.displaySmall())
                            .padding(.trailing, 240)
                        
                    TextField("", text: $text, prompt: Text("topBarSearchText")
                        .foregroundStyle(AppColors.dark.textTertiary))
                            .tint(AppColors.dark.textPrimary)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(AppColors.dark.textPrimary)
                            .frame(width: 200)
                    }
                }
                .padding(.trailing, )
                Image(systemName: "person.crop.circle")
                    .foregroundStyle(AppColors.dark.textPrimary)
                    .font(Font.displayGiga())
            }
            .padding(.horizontal, 20)
            .padding(.top, 5)
            
        }
    }
}

#Preview {
    DashboardView()
}
