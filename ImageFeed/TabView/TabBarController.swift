//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 18.06.2024.
//

import UIKit

final class TabBarController: UITabBarController{
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "imagesListViewController")
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController")
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}