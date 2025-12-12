//
//  MediaItem.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation

protocol MediaItem: Identifiable, Codable {
    var uniqueID: String { get }
    var displayTitle: String { get }
    var displayDescription: String? { get }
    var imageURL: String? { get }
    var rating: Double? { get }
    var releaseInfo: String? { get }
    var mediaType: MediaType { get }
}

enum MediaType: String, Codable {
    case movie
    case tvShow
    case anime
    case game
    case music
}
