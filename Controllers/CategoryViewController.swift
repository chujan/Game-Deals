//
//  CategoryViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 12/10/2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.tintColor = .label
        //spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
            
        
    }()
    var gameInfo: [GameInfo] = []
    
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
        
    }))
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spinner)
        spinner.startAnimating()
        addShareButton()
        view.backgroundColor = .systemBackground
        title = "Category"
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView .delegate = self
        collectionView.reloadData()
        configureSpinnerConstraints()
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        APICaller.shared.getFeaturedGame {  [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.gam = model
                    self?.gameInfo = model.map { game in
                        return GameInfo(genre: game.genre, platform: game.platform, releaseDate: game.releaseDate)
                       
                    }
                    self?.spinner.stopAnimating()
                    print(model)
                    self?.collectionView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func configureSpinnerConstraints() {
        // Add constraints to position the spinner within its superview
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Add other constraints as needed (width, height, etc.)
        ])
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
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 350, height: 70)
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gam.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = gam[indexPath.row]
        let randomBorderColor = borderColors.randomElement() ?? .systemBlue
        
       
        cell.configure(with: CategoryModel(genre: viewModel.genre, releaseDate: viewModel.releaseDate, platform: viewModel.platform), borderColor: randomBorderColor)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = gam[indexPath.row]
        let vc = FeaturedDetailViewController(gameData: gam)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

   


//extension CategoryListView: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row >= 0 && indexPath.row < gameData.count {
//            print("gameData contents: \(gameData)")
//            let selectedGame = gameData [indexPath.row]// Assuming gam is the array of Game objects
//            let featuredDetailVC = FeaturedDetailViewController(gameData: [selectedGame])
//            // Pass data to the FeaturedDetailViewController if needed
//            // featuredDetailVC.game = selectedGame
//            navigationController?.pushViewController(featuredDetailVC, animated: true)
//        } else {
//            print("Invalid index: \(indexPath.row)")
//        }
//    }
//}
