//
//  Game.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

struct Game:  MediaItem{
    let id: Int
    let name: String
    let description: String?
    let backgroundImage: String?
    let rating: Double?
    let released: String?
    
    var uniqueID: String { String(id) }
    var displayTitle: String { name }
    var displayDescription: String? { description }
    var imageURL: String? { backgroundImage }
    var releaseInfo: String? { released }
    var mediaType: MediaType { .game }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, rating, released
        case backgroundImage = "background_image"
    }
}

