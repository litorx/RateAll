//
//  Anime.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

struct Anime:  MediaItem {
    let malId: Int
    let title: String
    let synopsis: String?
    let images: AnimeImages?
    let score: Double?
    let aired: AnimeAired?
    
    var id: String { uniqueID }
    
    var uniqueID: String { String(malId) }
    var displayTitle: String { title }
    var displayDescription: String? { synopsis }
    var imageURL: String? { images?.jpg.imageUrl }
    var rating: Double? { score }
    var releaseInfo: String? { aired?.from }
    var mediaType: MediaType { .anime }
    
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case title, synopsis, images, score, aired
    }
    
}

struct AnimeImages: Codable {
    let jpg: AnimeImageURL
}

struct AnimeImageURL: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}

struct AnimeAired: Codable {
    let from: String?
}
