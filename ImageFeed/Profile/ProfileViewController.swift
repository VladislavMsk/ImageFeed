//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 25.12.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController{
    /*
    @IBOutlet private var avatarImageView: UIImageView!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton(_ sender: Any) {
    
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initNameLabel()
        initLoginName()
        initDescriptionLabel()
        initLogoutButton()
        initAvatrImageView()
        
    }
    
    private func initAvatrImageView(){
        let avatrImage = UIImage(named: "Userpick")
        let avatarImageView = UIImageView(image: avatrImage!)
        
        avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        }
    
    private func initNameLabel(){
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.text = "Екатерина Новикова"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .ypWhite
        nameLabel.font = .boldSystemFont(ofSize: 23)
        
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func initLoginName(){
        let loginName = UILabel()
        view.addSubview(loginName)
        loginName.text = "@ekaterina_nov"
        loginName.translatesAutoresizingMaskIntoConstraints = false
        loginName.textColor = .ypGray
        loginName.font = .systemFont(ofSize: 13)
        
        loginName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 144).isActive = true
        loginName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func initDescriptionLabel(){
        let descriptionLabel = UILabel()
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 168).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func initLogoutButton(){
        let logoutButton = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: ProfileViewController.self,
            action: #selector(Self.didTapButton))
        view.addSubview(logoutButton)
        logoutButton.tintColor = .ypRed
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
        
    
    @objc
    func didTapButton(){
    }
}
