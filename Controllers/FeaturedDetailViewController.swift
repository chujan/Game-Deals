//
//  FeaturedDetailViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 28/10/2023.
//



import UIKit
import SafariServices
enum sectionType: Int, CaseIterable {
    
    case ReleaseDate = 0
    case platform = 1
    case category = 2
    case info = 3
   
    
}



class FeaturedDetailViewController: UIViewController {
//        private var gameModel: GameModel
//
//        init(gam: [Game]) {
//            self.gameModel = GameModel(items: gam)
//            super.init(nibName: nil, bundle: nil)
//        }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    private var gameData: [Game] = []
    init(gameData: [Game]) {
        self.gameData = gameData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return FeaturedDetailViewController.createSectionLayout(section: sectionIndex)
        
    })
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        

        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeatureDetailCollectionViewCell.self, forCellWithReuseIdentifier: FeatureDetailCollectionViewCell.identifier)
        collectionView.register(ReleaseDateCollectionViewCell.self, forCellWithReuseIdentifier: ReleaseDateCollectionViewCell.identifier)
        collectionView.register(platformCollectionViewCell.self, forCellWithReuseIdentifier: platformCollectionViewCell.identifier)
        collectionView.register(FeaturedGameCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier)
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
   
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 3:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isiphone ? 0.5 : 0.20), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIDevice.isiphone ? 260 : 320)), subitems: UIDevice.isiphone ? [item, item] : [item,item, item,item])
            
            let section = NSCollectionLayoutSection(group: group)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
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

    private var gamWithBorders: [(model: CategoryModel, borderColor: UIColor)] = [] {
        didSet {
            // Handle the updated gamWithBorders array here
        }
    }

    private var gam: [Game] = [] {
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

extension FeaturedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case sectionType.category.rawValue, sectionType.ReleaseDate .rawValue, sectionType.platform .rawValue:
            
            return 1
        
        
            
        case sectionType.info.rawValue:
            return gameData.count
            
            //        case  Sections.Recommended.rawValue:
            //            return gi.count
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case sectionType.category.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureDetailCollectionViewCell.identifier, for: indexPath) as? FeatureDetailCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = gameData[indexPath.row]
            let randomBorderColor = borderColors.randomElement() ?? .systemBlue
            
            
            cell.configure(with: FeaturedDetailModel(genre: viewModel.genre, platform: viewModel.platform, releaseDate: viewModel.releaseDate), borderColor: randomBorderColor)
            return cell
        case sectionType.ReleaseDate.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReleaseDateCollectionViewCell.identifier, for: indexPath) as? ReleaseDateCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = gameData[indexPath.row]
            
            
            
            cell.configure(viewModel: ReleaseDateModel(releaseDate: viewModel.releaseDate))
            return cell
            
        case sectionType.platform.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: platformCollectionViewCell.identifier, for: indexPath) as? platformCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = gameData[indexPath.row]
            
            
            
            cell.configure(viewModel: PlatformModel(platform: viewModel.platform))
            return cell
            
            
        case sectionType.info.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier, for: indexPath) as? FeaturedGameCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = gameData[indexPath.row]
            
            
            
            cell.configure(with: FeaturedGameModel(title: viewModel.title, thumbnail: viewModel.thumbnail))
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameURL = gameData[indexPath.row].gameURL
        
        if let url = URL(string: gameURL) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .popover
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid URL")
        }
        
    }
}
   
    
    
    
