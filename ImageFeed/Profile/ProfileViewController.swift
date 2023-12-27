//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 25.12.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController{
    @IBOutlet private var avatarImageView: UIImageView!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton(_ sender: Any) {
    }
}
