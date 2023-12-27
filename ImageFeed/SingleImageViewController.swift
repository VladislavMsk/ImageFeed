//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 27.12.2023.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else {return}
            SingleImage.image = image
        }
    }
    
    @IBOutlet var SingleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SingleImage.image = image
    }
}
