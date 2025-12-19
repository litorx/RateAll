//
//  NavBarViewModel.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation
import Combine

struct TabItem: Identifiable {
    let id: Int
    let icon: String
    let title: String
}

@MainActor
final class NavBarViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    
    let tabs: [TabItem] = [
        TabItem(id: 0, icon: "movieclapper", title: "Filmes"),
        TabItem(id: 1, icon: "play.tv", title: "Séries"),
        TabItem(id: 2, icon: "wand.and.rays", title: "Animes"),
        TabItem(id: 3, icon: "gamecontroller", title: "Jogos"),
        TabItem(id: 4, icon: "headphones.circle", title: "Músicas")
    ]
    
    func selectTab(_ index: Int) {
        guard index >= 0 && index < tabs.count else { return }
        selectedTab = index
    }
}
