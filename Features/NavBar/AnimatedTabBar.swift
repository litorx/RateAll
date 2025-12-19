//
//  AnimatedTabBar.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import SwiftUI

struct AnimatedTabBar: View {
    let tabs: [TabItem]
    @Binding var selectedTab: Int
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                AnimatedTabButton(
                    icon: tab.icon,
                    title: tab.title,
                    tag: tab.id,
                    selectedTab: $selectedTab,
                    animation: animation
                )
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            AppColors.dark.reverseSearchGradient
                .shadow(color: .black.opacity(0.15), radius: 10, y: -2)
                .ignoresSafeArea()
        )
        
    }
}

struct AnimatedTabButton: View {
    let icon: String
    let title: String
    let tag: Int
    @Binding var selectedTab: Int
    var animation: Namespace.ID
    
    private var isSelected: Bool {
        selectedTab == tag
    }
    
    var body: some View {
        Button(action: handleTap) {
            VStack(spacing: 4) {
                iconView
                titleView
            }
            .foregroundColor(isSelected ? AppColors.dark.accent1 : AppColors.dark.textSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
        }
    }
    
    private var iconView: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(AppColors.dark.accent1.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: "tab", in: animation)
            }
            
            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
        }
    }
    
    private var titleView: some View {
        Text(title)
            .font(.system(size: 10))
            .fontWeight(isSelected ? .semibold : .medium)
    }
    
    private func handleTap() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedTab = tag
        }
    }
}

#Preview{
    DashboardView()
}
