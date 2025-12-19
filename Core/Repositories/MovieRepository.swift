//
//  MovieRepository.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation



protocol MovieRepositoryProtocol {
    func getTrendingMovies() async throws -> [Movie]
    func discoverMovies(filters: MovieFilters?) async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func getMovieDetails(id: Int) async throws -> Movie
}



final class MovieRepository: MovieRepositoryProtocol {
    private let service: TMDBService
    private let cacheManager: CacheManager<[Movie]>
    
    init(service: TMDBService, cacheManager: CacheManager<[Movie]> = CacheManager()) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    func getTrendingMovies() async throws -> [Movie] {
        let cacheKey = "trending_movies"
        

        if let cached = cacheManager.get(key: cacheKey, maxAge: 3600) {
            return cached
        }
        
        
        let movies = try await service.getTrendingMovies()
        

        cacheManager.set(key: cacheKey, value: movies)
        
        return movies
    }
    
    func discoverMovies(filters: MovieFilters?) async throws -> [Movie] {
        return try await service.discoverMovies(filters: filters)
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        guard !query.isEmpty else { return [] }
        return try await service.searchMovies(query: query)
    }
    
    func getMovieDetails(id: Int) async throws -> Movie {
        let cacheKey = "movie_\(id)"
  
        if let cached = cacheManager.get(key: cacheKey, maxAge: 86400),
           let first = cached.first {
            return first
        }
        
        let movie = try await service.getMovieDetails(id: id)
        cacheManager.set(key: cacheKey, value: [movie])
        
        return movie
    }
}
