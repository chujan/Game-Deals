//
//  FeaturedResponse.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 16/10/2023.
//

import Foundation

struct FeaturedResonse: Codable {
    let games: [Game]
   
}
struct Game: Codable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let releaseDate: String
    enum CodingKeys: String, CodingKey {
        case id,title, thumbnail,genre,platform
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case releaseDate = "release_date"
    }
}
