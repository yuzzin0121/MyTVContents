//
//  TabBarController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addViewController()
    }
    
    private func configureView() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
    }

    private func addViewController() {
        let homeVC = TVViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        homeVC.title = TabItem.home.rawValue
        homeVC.tabBarItem = UITabBarItem(title: TabItem.home.rawValue, image: TabItem.home.image, selectedImage: TabItem.home.selectedImage)
        
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        profileVC.title = TabItem.profile.rawValue
        profileVC.tabBarItem = UITabBarItem(title: TabItem.profile.rawValue, image: TabItem.profile.image, selectedImage: TabItem.profile.selectedImage)
        
        
        [homeNav, profileNav].forEach {
            $0.setupBarAppearance()
        }
        
        self.viewControllers = [homeNav, profileNav]
    }
}
