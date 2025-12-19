//
//  TVShowRepository.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation

protocol TVShowRepositoryProtocol {
    func getTrendingTVShows() async throws -> [TVShow]
    func discoverTVShows(filters: TVShowFilters?) async throws -> [TVShow]
    func searchTVShows(query: String) async throws -> [TVShow]
    func getTVShowDetails(id: Int) async throws -> TVShow
}

final class TVShowRepository: TVShowRepositoryProtocol {
    private let service: TMDBService
    private let cacheManager: CacheManager<[TVShow]>
    
    init(service: TMDBService, cacheManager: CacheManager<[TVShow]> = CacheManager()) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    func getTrendingTVShows() async throws -> [TVShow] {
        let cacheKey = "trending_tvshows"
        
        if let cached = cacheManager.get(key: cacheKey, maxAge: 3600) {
            return cached
        }
        
        let shows = try await service.getTrendingTVShows()
        cacheManager.set(key: cacheKey, value: shows)
        
        return shows
    }
    
    func discoverTVShows(filters: TVShowFilters?) async throws -> [TVShow] {
        return try await service.discoverTVShows(filters: filters)
    }
    
    func searchTVShows(query: String) async throws -> [TVShow] {
        guard !query.isEmpty else { return [] }
        return try await service.searchTVShows(query: query)
    }
    
    func getTVShowDetails(id: Int) async throws -> TVShow {
        let cacheKey = "tvshow_\(id)"
        
        if let cached = cacheManager.get(key: cacheKey, maxAge: 86400),
           let first = cached.first {
            return first
        }
        
        let show = try await service.getTVShowDetails(id: id)
        cacheManager.set(key: cacheKey, value: [show])
        
        return show
    }
}
