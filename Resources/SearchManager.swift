//
//  SearchManager.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 31/10/2023.
//

import Foundation

class SearchManager {
    static func filterGiveaways(_ giveaways: [Giveaway], with searchText: String) -> [Giveaway] {
        return giveaways.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    static func filterRecommended(_ recommended: [Giveaway], with searchText: String) -> [Giveaway] {
        return recommended.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    static func filterFeaturedGames(_ games: [Game], with searchText: String) -> [Game] {
        return games.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
}
