//
//  TVShow.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

struct TVShow:  MediaItem {
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let firstAirDate: String?
    
    var uniqueID: String { String(id) }
    var displayTitle: String { name }
    var displayDescription: String? { overview }
    var imageURL: String? {
        posterPath.map { "https://image.tmdb.org/t/p/w500\($0)" }
    }
    
    var rating: Double? { voteAverage }
    var releaseInfo: String? { firstAirDate }
    var mediaType: MediaType { .tvShow }
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
    }
}

