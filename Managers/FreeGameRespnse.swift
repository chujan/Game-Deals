//
//  FreeGameRespnse.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 02/11/2023.
//

import Foundation

struct FreeToGameResponse: Codable {
    let freeGames: [FreeGame]
    
    enum CodingKeys: String, CodingKey {
        case freeGames = "games"
    }
}

struct FreeGame: Codable {
    let id: Int
    let title: String
    let shortDescription: String
    let genre: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case shortDescription = "short_description"
        case genre
    }
}
