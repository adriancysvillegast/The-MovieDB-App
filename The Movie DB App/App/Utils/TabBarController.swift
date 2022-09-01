//
//  TabBarController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - properties
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        navigationItem.hidesBackButton = true
        setupVCs()

    }
    
    //MARK: - createNavController
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }

    func setupVCs() {
            viewControllers = [
                createNavController(for: MovieViewController(), title: NSLocalizedString("Movies", comment: ""), image: UIImage(systemName: "tv")!),
                createNavController(for: TVViewController(), title: "TV Show", image: UIImage(systemName: "play.tv")!)
                
            ]
        }
    


}
