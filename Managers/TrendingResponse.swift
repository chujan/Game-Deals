//
//  TrendingModel.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 13/10/2023.
//

import Foundation
struct TrendingResponse: Codable {
    let giveaway: [Giveaway]
}
struct Giveaway: Codable {
    let id: Int
    let title: String
    let worth: String
    let thumbnail: String
    let image: String
    let type: String
    let description: String
    let instructions: String
    let openGiveawayURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, worth, thumbnail, image, description, instructions, type
        case openGiveawayURL = "open_giveaway_url"
    }
}
