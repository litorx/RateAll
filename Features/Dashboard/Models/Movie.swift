//
//  Movie.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

struct Movie:  MediaItem {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let releaseDate: String?
    
    var uniqueID: String { String(id) }
    var displayTitle: String { title }
    var displayDescription: String? { overview }
    var imageURL: String? {
        posterPath.map { "https://image.tmdb.org/t/p/w500\($0)" }
    }
    var rating: Double? { voteAverage }
    var releaseInfo: String? { releaseDate }
    var mediaType: MediaType { .movie }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

