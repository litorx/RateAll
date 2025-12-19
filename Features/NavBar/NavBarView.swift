//
//  NavBarView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import SwiftUI

struct NavBarView: View {
    @StateObject private var viewModel = NavBarViewModel()
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabContent
            
            AnimatedTabBar(
                tabs: viewModel.tabs,
                selectedTab: $viewModel.selectedTab,
                animation: animation
            )
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch viewModel.selectedTab {
        case 0: MoviesView()
        case 1: TVShowView()
        case 2: AnimeView()
        case 3: GamesView()
        case 4: MusicsView()
        default: MoviesView()
        }
    }
}

#Preview {
    DashboardView()
}
