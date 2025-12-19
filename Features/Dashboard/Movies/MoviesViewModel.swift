//
//  MoviesViewModel.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation
import Combine

struct MovieSection: Identifiable {
    let id = UUID()
    let title: String
    let genreId: Int
    var movies: [Movie] = []
}

@MainActor
final class MoviesViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var sections: [MovieSection] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: MovieRepositoryProtocol
    
    // Gêneros mais populares (você pode ajustar a ordem)
    private let popularGenres: [(id: Int, name: String)] = [
        (28, "Ação"),
        (35, "Comédia"),
        (18, "Drama"),
        (27, "Terror"),
        (878, "Ficção Científica"),
        (53, "Suspense"),
        (10749, "Romance"),
        (16, "Animação")
    ]
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadContent() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Carrega filmes em alta
            async let trending = repository.getTrendingMovies()
            
            // Carrega filmes por gênero
            let genreSections = await loadMoviesByGenres()
            
            trendingMovies = try await trending
            sections = genreSections
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func loadMoviesByGenres() async -> [MovieSection] {
        await withTaskGroup(of: MovieSection?.self) { group in
            for genre in popularGenres {
                group.addTask {
                    do {
                        let filters = MovieFilters(
                            genres: [genre.id],
                            sortBy: "popularity.desc"
                        )
                        let movies = try await self.repository.discoverMovies(filters: filters)
                        return MovieSection(
                            title: genre.name,
                            genreId: genre.id,
                            movies: Array(movies.prefix(10)) // Limita a 10 por seção
                        )
                    } catch {
                        return nil
                    }
                }
            }
            
            var sections: [MovieSection] = []
            for await section in group {
                if let section = section {
                    sections.append(section)
                }
            }
            
            // Ordena seções pela ordem original dos gêneros
            return sections.sorted { first, second in
                let firstIndex = popularGenres.firstIndex { $0.id == first.genreId } ?? 999
                let secondIndex = popularGenres.firstIndex { $0.id == second.genreId } ?? 999
                return firstIndex < secondIndex
            }
        }
    }
    
    func refresh() async {
        await loadContent()
    }
}
