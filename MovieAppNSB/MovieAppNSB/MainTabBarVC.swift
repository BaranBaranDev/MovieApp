//
//  MainTabBarVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit

final class MainTabBarVC: UITabBarController {
    
 
    
 // MARK: - Properties
    private let vc1 = UINavigationController(rootViewController: HomeBuilder.make())
    private let vc2 = UINavigationController(rootViewController: UpcomingBuilder.make())
    private let vc3 = UINavigationController(rootViewController: SearchBuilder.make())
    private let vc4 = UINavigationController(rootViewController: DownloadBuilder.make())
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Helpers
private extension MainTabBarVC {
    func setup() {
        setupTabBarItems()
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    
    func setupTabBarItems() {
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
    }
    
}

