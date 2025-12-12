//
//  Track.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

struct Music: MediaItem {
    let id: String
    let name: String
    let artists: [Artist]
    let album: Album
    let duration_ms: Int
    let preview_url: String?
    let popularity: Int?
    
    var uniqueID: String { id }  
    var displayTitle: String { name }
    var displayDescription: String? {
        artists.map { $0.name }.joined(separator: ", ")
    }
    var imageURL: String? {
        album.images.first?.url
    }
    var rating: Double? {
        popularity.map { Double($0) / 10.0 }
    }
    var releaseInfo: String? {
        album.release_date
    }
    var mediaType: MediaType { .music }
}


struct Artist: Codable {
    let id: String
    let name: String
}

struct Album: Codable {
    let id: String
    let name: String
    let images: [SpotifyImage]
    let release_date: String?
}

struct SpotifyImage: Codable {
    let url: String
    let height: Int?
    let width: Int?
}
