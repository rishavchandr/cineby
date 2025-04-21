//
//  ViewController.swift
//  cineby
//
//  Created by Rishav chandra on 16/03/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let VC1 = UINavigationController(rootViewController: DownloadViewController())
        let VC2 = UINavigationController(rootViewController: HomeViewController())
        let VC3 = UINavigationController(rootViewController: SearchViewController())
        let VC4 = UINavigationController(rootViewController: UpcomingViewController())
        
        
        VC2.tabBarItem.image = UIImage(systemName: "house")
        VC3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        VC4.tabBarItem.image = UIImage(systemName: "play.circle")
        VC1.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        VC2.tabBarItem.title = "Home"
        VC3.tabBarItem.title = "Top Search"
        VC4.tabBarItem.title = "Comming Soon"
        VC1.tabBarItem.title = "Download"
        
        tabBar.tintColor = .label
        
        setViewControllers([VC2 , VC3 , VC4 , VC1], animated: true)
    }
}

