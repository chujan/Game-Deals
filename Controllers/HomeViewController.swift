//
//  HomeViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 20/10/2023.
//

import UIKit

enum Sections: Int, CaseIterable {
    case Treading = 0
    case Recommended = 1
    case Featured = 2
    
    
    
}

class HomeViewController: UIViewController {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.tintColor = .label
        //spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
            
        
    }()
    
    private var gameModel: GameModel!
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return HomeViewController.createSectionLayout(section: sectionIndex)
        
    })
    let sectionTitles: [String] = ["Treanding", "Recommended", "Featured"]
    private var give: [Giveaway] = []
    private var gi: [Giveaway] = []
    private var gam: [Game] = []
    private var giveaway : Giveaway!
    
    
   
    
    //private var sections = [BrowseSectionType]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        collectionView.reloadData()
        view.addSubview(collectionView)
        view.addSubview(spinner)
        spinner.startAnimating()
      
       
        view.backgroundColor = .systemBackground
       
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        fetchData()
        configureSpinnerConstraints()
        configureCollectionViewCell()
       
        addShareButton()

       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func fetchData() {
        spinner.startAnimating()
        APICaller.shared.getTrending {  [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.give = model
                    self?.collectionView.reloadData()
                   // print(model)
                    self?.spinner.stopAnimating()
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
           
        }
        spinner.startAnimating()
        APICaller.shared.getRecommended { [weak self] result in
            
            switch result {
                
            case.success(let model):
                DispatchQueue.main.async {
                    self?.gi = model
                    self?.collectionView.reloadData()
                    self?.spinner.stopAnimating()
                }
               
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        spinner.startAnimating()
        APICaller.shared.getFeaturedGame { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.gam = model
                    self?.collectionView.reloadData()
                    self?.spinner.stopAnimating()
                   
                }
               
            case.failure(let error):
                print(error.localizedDescription)
            }
           
        }
       
        
    }
    
    private func configureCollectionViewCell() {
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.cellIdentifier)
        collectionView.register(RecommendedCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedCollectionViewCell.cellIdentifier)
        collectionView.register(FeaturedGameCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier)
    }
    private func configureSpinnerConstraints() {
        // Add constraints to position the spinner within its superview
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Add other constraints as needed (width, height, etc.)
        ])
    }
    
    
  
    

    
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [ NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)), repeatingSubitem: item, count: 3)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200)), repeatingSubitem: verticalGroup, count: 1)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), repeatingSubitem: item, count: 2)
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), repeatingSubitem: verticalGroup, count: 1)
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.boundarySupplementaryItems = supplementaryViews
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(160)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension:.absolute(140), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            let horizontalgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(200)), repeatingSubitem: verticalGroup, count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalgroup)
            section.orthogonalScrollingBehavior = .continuous
            
            section.boundarySupplementaryItems = supplementaryViews
           
            return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
           
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            
            return section
            
        }
       
    }
    
    private  func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = SearchViewController()
      
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
   

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Sections.Treading.rawValue:
            
            return give.count
        case  Sections.Recommended.rawValue:
            return gi.count
        case Sections.Featured.rawValue:
            return gam.count
            
        default:
            return 0
        }
        
        
        
       
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let type = sections[indexPath.section]
        switch indexPath.section {
        case Sections.Treading.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.cellIdentifier, for: indexPath) as? TrendingCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = give[indexPath.row]
            
           
            cell.configure(with: TrendingModel(title: viewModel.title, thumbnail: viewModel.thumbnail))
            return cell
            
        
        case Sections.Recommended.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCollectionViewCell.cellIdentifier, for: indexPath) as? RecommendedCollectionViewCell else {
                return UICollectionViewCell()
            }
          
            let viewModel = gi[indexPath.row]
            cell.configure(with: RecommendedModel(title: viewModel.title, thumbnail: viewModel.thumbnail))
            return cell
            
        case Sections.Featured.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier, for: indexPath) as? FeaturedGameCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = gam[indexPath.row]
            cell.configure(with: FeaturedGameModel(title: viewModel.title, thumbnail: viewModel.thumbnail))
            return cell
          
        default:
            return UICollectionViewCell()
        }
        //return cell
   
            
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
           return UICollectionReusableView()
        }
        let section = indexPath.section
       let title = sectionTitles[section]
       header.configure(with: title)
       return header
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let section = Sections(rawValue: indexPath.section)
        print("Selected section: \(indexPath.section)")
        switch section {
        case .Treading:
            if let selectedGiveaway = give[safe: indexPath.row] {
                let detailViewController = HomeDetailViewController(giveaway: selectedGiveaway)
                //detailViewController.title = selectedGiveaway.title
                detailViewController.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        case .Recommended:
            print("Did select item at indexPath: \(indexPath)")
            
            if let selectedGiveaway = give[safe: indexPath.row]{
                
                let detailViewController = HomeDetailViewController(giveaway: selectedGiveaway)
             
                //detailViewController.title = selectedGiveaway.title
                detailViewController.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(detailViewController, animated: true)
            }
            
           
        case .Featured:
            let selectedGame = gam[safe: indexPath.row]
            let allGames = gam
            let vc = CategoryDetailViewController(singleGame: selectedGame, allGames: allGames)
            navigationController?.pushViewController(vc, animated: true)
            
        case .none:
            break
        }
    }


    
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

