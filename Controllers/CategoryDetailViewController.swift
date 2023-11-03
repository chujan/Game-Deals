//
//  CategoryDetailViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 27/10/2023.
//
//enum Sections: Int, CaseIterable {
//    case Treading = 0
//    case Recommended = 1
//    case Featured = 2
//
 
class GameModel {
    var items: [Game] // Assuming Game is the appropriate item type

    init(items: [Game]) {
        self.items = items
    }

    var count: Int {
        return items.count
    }
}


import UIKit
import SafariServices
//enum sectionType: Int, CaseIterable {
//    case category = 0
//    case info = 1
//
//}

class CategoryDetailViewController: UIViewController {
    public var singleGame: Game?
    public var allGames: [Game] = []
    init(singleGame: Game?, allGames: [Game]) {
        self.singleGame = singleGame
        self.allGames = allGames
        super.init(nibName: nil, bundle: nil)
    }
    
//    private var gameModel: GameModel
//
//    init(gam: [Game]) {
//        self.gameModel = GameModel(items: gam)
//        super.init(nibName: nil, bundle: nil)
//    }
//
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return CategoryDetailViewController.createSectionLayout(section: sectionIndex)
        
    })
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        title = singleGame?.title
        view.addSubview(collectionView)
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
   
        private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                return section
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            default:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            }
            
            
        }
    private let borderColors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemPurple,
        .systemGreen,
        .systemOrange,
        .systemYellow,
        .systemPink,
        .systemIndigo,
        .systemMint
    ]

    public var gamWithBorders: [(model: CategoryModel, borderColor: UIColor)] = [] {
        didSet {
            // Handle the updated gamWithBorders array here
        }
    }

    public var gam: [Game] = [] {
        didSet {
            // Update gamWithBorders array with CategoryModel and random border colors
            gamWithBorders = gam.map { game in
                let randomBorderColor = borderColors.randomElement() ?? .systemBlue
                let categoryModel = CategoryModel(genre: game.genre, releaseDate: game.releaseDate, platform: game.platform)
                return (model: categoryModel, borderColor: randomBorderColor)
            }
        }
    }
    
    
    
    
    

}
extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return singleGame != nil ? 1 : 0
        } else {
            return allGames.count
        }
    
    
//    case Sections.Treading.rawValue:
//
//        return give.count
//    case  Sections.Recommended.rawValue:
//        return gi.count
//    case Sections.Featured.rawValue:
//        return gam.count
//
//    default:
//        return 0
    }
    
      
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PhotoCollectionViewCell.identifier , for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewmodels = singleGame
            cell.configure(viewModels: photoModel(thumbnail:singleGame?.thumbnail ?? "Default" , shortDescription: singleGame?.shortDescription ?? "defaultDes"))
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,  for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModels = allGames[indexPath.row]
            let randomBorderColor = borderColors.randomElement() ?? .systemBlue
            cell.configure(with: CategoryModel(genre: viewModels.genre, releaseDate: viewModels.releaseDate, platform: viewModels.platform), borderColor: randomBorderColor)
            return cell
        }

   }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameURL = allGames[indexPath.row].gameURL
        
        if let url = URL(string: gameURL) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .popover
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid URL")
        }
    }
    
    
}

