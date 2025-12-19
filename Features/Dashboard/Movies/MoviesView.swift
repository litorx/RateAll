//
//  MoviesView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = DependencyContainer.shared.makeMoviesViewModel()
    
    var body: some View {
        ZStack {
            AppColors.dark.backgroundGradient
                .ignoresSafeArea()
            
            if viewModel.isLoading && viewModel.trendingMovies.isEmpty {
                ProgressView()
                    .tint(AppColors.dark.accent1)
            } else if let error = viewModel.errorMessage {
                ErrorView(message: error) {
                    Task {
                        await viewModel.refresh()
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        if !viewModel.trendingMovies.isEmpty {
                            TrendingSection(movies: viewModel.trendingMovies)
                                .padding(.top, 20)
                        }
                        
                        ForEach(viewModel.sections) { section in
                            GenreSection(section: section)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .task {
            await viewModel.loadContent()
        }
        .refreshable {
            await viewModel.refresh()
        }
    }
}

struct TrendingSection: View {
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Em Alta Esta Semana")
                .font(.headlineLarge)
                .foregroundColor(AppColors.dark.textPrimary)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies, id: \.id) { movie in
                        TrendingMovieCard(movie: movie)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct TrendingMovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: movie.imageURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Color.gray.opacity(0.3)
                            .overlay {
                                Image(systemName: "film")
                                    .foregroundColor(AppColors.dark.textTertiary)
                            }
                    case .empty:
                        Color.gray.opacity(0.3)
                            .overlay {
                                ProgressView()
                                    .tint(AppColors.dark.accent2)
                            }
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: 160, height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                if let rating = movie.rating {
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(AppColors.dark.accent1)
                        
                        Text(String(format: "%.1f", rating))
                            .font(.captionSmall)
                            .foregroundColor(AppColors.dark.textPrimary)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.black.opacity(0.75))
                    )
                    .padding(8)
                }
            }
            
            Text(movie.displayTitle)
                .font(.labelMedium)
                .foregroundColor(AppColors.dark.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 160, height: 36, alignment: .topLeading)
        }
    }
}

struct GenreSection: View {
    let section: MovieSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(section.title)
                .font(.headlineMedium)
                .foregroundColor(AppColors.dark.textPrimary)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(section.movies, id: \.id) { movie in
                        GenreMovieCard(movie: movie)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct GenreMovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: movie.imageURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Color.gray.opacity(0.3)
                            .overlay {
                                Image(systemName: "film")
                                    .foregroundColor(AppColors.dark.textTertiary)
                            }
                    case .empty:
                        Color.gray.opacity(0.3)
                            .overlay {
                                ProgressView()
                                    .tint(AppColors.dark.accent2)
                            }
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(width: 120, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppColors.dark.textTertiary.opacity(0.1), lineWidth: 1)
                )
                
                if let rating = movie.rating {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 8))
                            .foregroundColor(AppColors.dark.accent1)
                        
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 10))
                            .foregroundColor(AppColors.dark.textPrimary)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black.opacity(0.75))
                    )
                    .padding(6)
                }
            }
            
            Text(movie.displayTitle)
                .font(.labelSmall)
                .foregroundColor(AppColors.dark.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 120, height: 32, alignment: .topLeading)
        }
    }
}

struct ErrorView: View {
    let message: String
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(AppColors.dark.accent1)
            
            Text("Ops! Algo deu errado")
                .font(.headlineSmall)
                .foregroundColor(AppColors.dark.textPrimary)
            
            Text(message)
                .font(.bodySmall)
                .foregroundColor(AppColors.dark.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: retry) {
                Text("Tentar Novamente")
                    .font(.labelMedium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        AppColors.dark.reverseSearchGradient
                    )
                    .clipShape(Capsule())
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    MoviesView()
}
