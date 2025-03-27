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
        view.backgroundColor = .systemMint
    }
    
    let VC1 = UINavigationController(rootViewController: DownloadViewController())
    let VC2 = UINavigationController(rootViewController: HomeViewController())
    let VC3 = UINavigationController(rootViewController: SearchViewController())
    let VC4 = UINavigationController(rootViewController: UpcomingViewController())
    
    
    
    

}

