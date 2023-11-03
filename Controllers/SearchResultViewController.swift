//
//  SearchResultViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 01/11/2023.
//

import UIKit





protocol SearchResultSelectionDelegate: AnyObject {
    func didSelectSearchResult(_ selectedGame: Game)
    
   
    
   
        
        
}

class SearchResultViewController: UIViewController {
    weak var selectionDelegate: SearchResultSelectionDelegate?
    
    func convertToGame(from freeGame: FreeGame) -> Game {
        let game = Game(
            id: freeGame.id,
            title: freeGame.title,
            thumbnail: freeGame.thumbnail,
            shortDescription: freeGame.genre,
            gameURL: freeGame.title,
            genre: freeGame.genre,
            platform: freeGame.shortDescription,
            releaseDate: freeGame.title
            // Add other properties as needed
        )
        
        return game
    }

    
//    privat
    
    
    
   
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isiphone ? 0.5 : 0.20), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIDevice.isiphone ? 260 : 320)), subitems: UIDevice.isiphone ? [item, item] : [item,item, item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        return section
    }))
  
    


    public var search = [FreeGame]()
    var gam = [Game]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.cellIdentifier)
        
        

        
    }
   

    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    
    public func showNoResultsAlert() {
        let alert = UIAlertController(title: "No Results Found", message: "No games matching your search query were found.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
}
extension SearchResultViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return search.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.cellIdentifier, for: indexPath) as? SearchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewmodel = search[indexPath.row]
        cell.configure(with:SearchResultModel(title: viewmodel.title , thumbnail: viewmodel.thumbnail))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFreeGame = search[indexPath.row]
            let selectedGame = convertToGame(from: selectedFreeGame)
            selectionDelegate?.didSelectSearchResult(selectedGame)
        }
    
}





