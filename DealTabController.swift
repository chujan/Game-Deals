//
//  DealTabController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 11/10/2023.
//

import UIKit

class DealTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    private func setUpTabs() {
        let trendingVC = HomeViewController()
        let categoryVC = CategoryViewController()
        let recommendedVC = InstructionViewController()
       
        trendingVC.navigationItem.largeTitleDisplayMode = .automatic
        categoryVC.navigationItem.largeTitleDisplayMode = .automatic
        recommendedVC.navigationItem.largeTitleDisplayMode = .automatic
       
        
        let nav1 = UINavigationController(rootViewController: trendingVC)
        let nav2 = UINavigationController(rootViewController: categoryVC)
        let nav3 = UINavigationController(rootViewController: recommendedVC)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "gamecontroller"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "dpad"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Instructions", image: UIImage(systemName: "circle.grid.cross.fill"), tag: 3)
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
    

   
}
