//
//  SearchViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 31/10/2023.
//

// TitleHeaderCollectionReusableView.swift




import UIKit

class SearchViewController: UIViewController  {
    private let searchController: UISearchController = {
        let searchResultsController = SearchResultViewController()

        let controller = UISearchController(searchResultsController: searchResultsController)
        controller.searchBar.placeholder = "Search for Game"
        controller.searchBar.backgroundColor = .white
        controller.searchBar.translatesAutoresizingMaskIntoConstraints = false
        controller.searchBar.searchBarStyle = .minimal

        return controller
    }()


    
    
    
    private var gam: [Game] = []
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isiphone ? 0.5 : 0.20), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIDevice.isiphone ? 260 : 320)), subitems: UIDevice.isiphone ? [item, item] : [item,item, item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        return section
    }))


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets.zero
        view.addSubview(collectionView)
       collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchResultsUpdater = self
        collectionView.reloadData()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        definesPresentationContext = true
        collectionView.register(FeaturedGameCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier)
        addConstraint()
        APICaller.shared.getFeaturedGame { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.gam = model
                    self?.collectionView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
       
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(searchController.searchBar.frame)
           print(collectionView.frame)

        collectionView.frame = view.bounds
    }
    
    private func addConstraint() {
        // Make sure to set translatesAutoresizingMaskIntoConstraints to false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the search bar to the view
        view.addSubview(searchController.searchBar)
        
        NSLayoutConstraint.activate([
            searchController.searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchController.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            
        ])
    }


    
    
    


   

    

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("see:\(gam.count)")
        return gam.count
       
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedGameCollectionViewCell.cellIdentifier, for: indexPath) as? FeaturedGameCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = gam[indexPath.row]
        cell.configure(with: FeaturedGameModel(title: viewModel.title, thumbnail: viewModel.thumbnail))
        return cell
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = gam[indexPath.row] // Ensure this index is valid
        let categoryDetailVC = CategoryDetailViewController(singleGame: selectedGame, allGames: gam)
        if let navigationController = navigationController {
            navigationController.pushViewController(categoryDetailVC, animated: true)
        } else {
            print("Error: Navigation Controller is nil.")
        }
    }



}
extension SearchViewController: UISearchResultsUpdating, SearchResultSelectionDelegate {
    
    func didSelectSearchResult(_ selectedGame: Game) {
        let categoryDetailVC = CategoryDetailViewController(singleGame: selectedGame, allGames: gam)
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController
        else {
            return
        }
        
        resultController.selectionDelegate = self
        APICaller.shared.getSearch(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    if model.isEmpty {
                        resultController.showNoResultsAlert()
                    } else {
                        resultController.collectionView.reloadData()
                        resultController.search = model
                    }
                    
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                
            }
        }
        
        
        
    }
}
    

