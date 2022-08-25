//
//  TabBarController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - properties
    
    let userRepository = UserRepository()
    
    private lazy var profileBotton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(goToProfile))
        return button
    }()
    
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        self.navigationItem.rightBarButtonItem = profileBotton
        navigationItem.hidesBackButton = true
        setupVCs()

    }
    
    //MARK: - add targets
    
    @objc func goToProfile() {
        
        let alert = UIAlertController(title: "What do you want to do?", message: "", preferredStyle: .actionSheet)
        let navigateProfile = UIAlertAction(title: "View Profile", style: .default) { _ in
            let vc = ProfileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let navigateHome = UIAlertAction(title: "Log Out", style: .default) { _ in
            self.userRepository.logOut()
            let vc = LogInViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(navigateProfile)
        alert.addAction(navigateHome)
        alert.addAction(cancel)
        present(alert, animated: true)
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
