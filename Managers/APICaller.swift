//
//  APICaller.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 13/10/2023.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    private init() {}
    
    
    func getTreadingDetail(for giveaways: Giveaway, completion: @escaping(Result<TrendingDetailResponse, Error>) -> Void) {
        guard let url = URL(string: "https://www.gamerpower.com/api/giveaways?type=game") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingDetailResponse.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    

    func getTrending(completion: @escaping (Result<[Giveaway],Error>) -> Void) {
        guard let url = URL(string:"https://www.gamerpower.com/api/giveaways?platform=pc") else {
            print("invalid URL")
                  return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode([Giveaway].self, from: data)
                completion(.success(results))
                //print(results)
            }
            catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
                
    }
    func getRecommended(completion: @escaping (Result<[Giveaway],Error>) -> Void) {
        guard let url = URL(string:"https://www.gamerpower.com/api/giveaways?sort-by=value") else {
            print("invalid URL")
                  return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode([Giveaway].self, from: data)
                completion(.success(results))
                //print(results)
            }
            catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
                
    }
    
    
    
    func getFeaturedGame(completion: @escaping (Result<[Game],Error>) -> Void) {
        guard let url = URL(string:"https://www.freetogame.com/api/games") else {
            print("invalid URL")
                  return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode([Game].self, from: data)
                completion(.success(results))
                //print(results)
            }
            catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
                
    }
    
    func getSearch(with query: String, completion: @escaping(Result<[FreeGame], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://www.freetogame.com/api/games?sort-by=relevance\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode([FreeGame].self, from: data)
                let filterdResults = results.filter { game in
                    return game.title.range(of: query, options: .caseInsensitive)  != nil
                }
                if filterdResults.isEmpty {
                    print("No results found for query: \(query)")
                    completion(.failure(CustomError.noResultsFound))
                }
                completion(.success(filterdResults))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    
    
    
}

enum CustomError: Error {
    
    case noResultsFound
}
