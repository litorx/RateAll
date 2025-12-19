//
//  DependencyContainer.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Services
    
    private lazy var tmdbService: TMDBService = {
        TMDBService(apiKey: "ebe33d90630d83b58154723e31d83ad4")
    }()
    
    // MARK: - Repositories
    
    lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(service: tmdbService)
    }()
    
    lazy var tvShowRepository: TVShowRepositoryProtocol = {
        TVShowRepository(service: tmdbService)
    }()
    
    // MARK: - ViewModels
    
    func makeMoviesViewModel() -> MoviesViewModel {
        MoviesViewModel(repository: movieRepository)
    }
    

}
