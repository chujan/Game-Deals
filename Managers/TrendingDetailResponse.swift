//
//  TrendingDetailResponse.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 25/10/2023.
//

import Foundation
struct TrendingDetailResponse: Codable {
    //let giveaways: [Giveaway]
    let title: String
    let worth: String
    let platforms: [String]
    let description: String
    let image: String
    let open_giveaway: String
    let end_giveaway: String
    let requirements: String
    let giveaway_url: String
}
//    enum CodingKeys: String, CodingKey {
//        case
//        //title, worth, thumbnail,
//        image
//        //description, instructions,
//        //case openGiveawayURL = "open_giveaway_url"
//    }
//}

struct GiveawaysResponse: Codable {
    let giveaways: [Giveaway]
}

struct GameInfo {
    let genre: String
    let platform: String
    let releaseDate: String
}

