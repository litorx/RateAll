//
//  TMDBService.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation

enum TMDBEndpoint {
    case trendingMovies(timeWindow: String = "week")
    case trendingTVShows(timeWindow: String = "week")
    case discoverMovies(filters: MovieFilters?)
    case discoverTVShows(filters: TVShowFilters?)
    case searchMovies(query: String)
    case searchTVShows(query: String)
    case movieDetails(id: Int)
    case tvShowDetails(id: Int)
    
    var path: String {
        switch self {
        case .trendingMovies(let timeWindow):
            return "/trending/movie/\(timeWindow)"
        case .trendingTVShows(let timeWindow):
            return "/trending/tv/\(timeWindow)"
        case .discoverMovies:
            return "/discover/movie"
        case .discoverTVShows:
            return "/discover/tv"
        case .searchMovies:
            return "/search/movie"
        case .searchTVShows:
            return "/search/tv"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .tvShowDetails(let id):
            return "/tv/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        switch self {
        case .discoverMovies(let filters):
            if let filters = filters {
                items.append(contentsOf: filters.toQueryItems())
            }
        case .discoverTVShows(let filters):
            if let filters = filters {
                items.append(contentsOf: filters.toQueryItems())
            }
        case .searchMovies(let query), .searchTVShows(let query):
            items.append(URLQueryItem(name: "query", value: query))
        default:
            break
        }
        
        return items
    }
}

// MARK: - Filters

struct MovieFilters {
    var genres: [Int]?
    var yearFrom: Int?
    var yearTo: Int?
    var ratingFrom: Double?
    var ratingTo: Double?
    var sortBy: String? // "popularity.desc", "vote_average.desc", "release_date.desc"
    var language: String? // "pt-BR", "en-US"
    
    func toQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let genres = genres, !genres.isEmpty {
            items.append(URLQueryItem(name: "with_genres", value: genres.map(String.init).joined(separator: ",")))
        }
        if let yearFrom = yearFrom {
            items.append(URLQueryItem(name: "primary_release_date.gte", value: "\(yearFrom)-01-01"))
        }
        if let yearTo = yearTo {
            items.append(URLQueryItem(name: "primary_release_date.lte", value: "\(yearTo)-12-31"))
        }
        if let ratingFrom = ratingFrom {
            items.append(URLQueryItem(name: "vote_average.gte", value: String(ratingFrom)))
        }
        if let ratingTo = ratingTo {
            items.append(URLQueryItem(name: "vote_average.lte", value: String(ratingTo)))
        }
        if let sortBy = sortBy {
            items.append(URLQueryItem(name: "sort_by", value: sortBy))
        }
        if let language = language {
            items.append(URLQueryItem(name: "with_original_language", value: language))
        }
        
        return items
    }
}

struct TVShowFilters {
    var genres: [Int]?
    var yearFrom: Int?
    var yearTo: Int?
    var ratingFrom: Double?
    var ratingTo: Double?
    var sortBy: String?
    var status: String? // "Returning Series", "Ended", "Canceled"
    
    func toQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let genres = genres, !genres.isEmpty {
            items.append(URLQueryItem(name: "with_genres", value: genres.map(String.init).joined(separator: ",")))
        }
        if let yearFrom = yearFrom {
            items.append(URLQueryItem(name: "first_air_date.gte", value: "\(yearFrom)-01-01"))
        }
        if let yearTo = yearTo {
            items.append(URLQueryItem(name: "first_air_date.lte", value: "\(yearTo)-12-31"))
        }
        if let ratingFrom = ratingFrom {
            items.append(URLQueryItem(name: "vote_average.gte", value: String(ratingFrom)))
        }
        if let ratingTo = ratingTo {
            items.append(URLQueryItem(name: "vote_average.lte", value: String(ratingTo)))
        }
        if let sortBy = sortBy {
            items.append(URLQueryItem(name: "sort_by", value: sortBy))
        }
        if let status = status {
            items.append(URLQueryItem(name: "with_status", value: status))
        }
        
        return items
    }
}

// MARK: - Response Models

struct TMDBMovieResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TMDBTVShowResponse: Decodable {
    let results: [TVShow]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Service

enum TMDBError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case apiError(String)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Resposta inválida do servidor"
        case .apiError(let message):
            return message
        case .decodingError:
            return "Erro ao processar dados"
        }
    }
}

@MainActor
final class TMDBService {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    // MARK: - Private Methods
    
    private func buildURL(endpoint: TMDBEndpoint) -> URL? {
        var components = URLComponents(string: baseURL + endpoint.path)
        
        var queryItems = endpoint.queryItems
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        queryItems.append(URLQueryItem(name: "language", value: "pt-BR"))
        
        components?.queryItems = queryItems
        return components?.url
    }
    
    private func performRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw TMDBError.apiError("Status code: \(httpResponse.statusCode)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw TMDBError.decodingError
        }
    }
    
    // MARK: - Public Methods - Movies
    
    func getTrendingMovies(timeWindow: String = "week") async throws -> [Movie] {
        guard let url = buildURL(endpoint: .trendingMovies(timeWindow: timeWindow)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBMovieResponse = try await performRequest(url: url)
        return response.results
    }
    
    func discoverMovies(filters: MovieFilters? = nil) async throws -> [Movie] {
        guard let url = buildURL(endpoint: .discoverMovies(filters: filters)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBMovieResponse = try await performRequest(url: url)
        return response.results
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        guard let url = buildURL(endpoint: .searchMovies(query: query)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBMovieResponse = try await performRequest(url: url)
        return response.results
    }
    
    func getMovieDetails(id: Int) async throws -> Movie {
        guard let url = buildURL(endpoint: .movieDetails(id: id)) else {
            throw TMDBError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
    
    // MARK: - Public Methods - TV Shows
    
    func getTrendingTVShows(timeWindow: String = "week") async throws -> [TVShow] {
        guard let url = buildURL(endpoint: .trendingTVShows(timeWindow: timeWindow)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBTVShowResponse = try await performRequest(url: url)
        return response.results
    }
    
    func discoverTVShows(filters: TVShowFilters? = nil) async throws -> [TVShow] {
        guard let url = buildURL(endpoint: .discoverTVShows(filters: filters)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBTVShowResponse = try await performRequest(url: url)
        return response.results
    }
    
    func searchTVShows(query: String) async throws -> [TVShow] {
        guard let url = buildURL(endpoint: .searchTVShows(query: query)) else {
            throw TMDBError.invalidURL
        }
        
        let response: TMDBTVShowResponse = try await performRequest(url: url)
        return response.results
    }
    
    func getTVShowDetails(id: Int) async throws -> TVShow {
        guard let url = buildURL(endpoint: .tvShowDetails(id: id)) else {
            throw TMDBError.invalidURL
        }
        
        return try await performRequest(url: url)
    }
}
