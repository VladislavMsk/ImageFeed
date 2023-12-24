//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 12.12.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell{
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dataLabel: UILabel!
    }
