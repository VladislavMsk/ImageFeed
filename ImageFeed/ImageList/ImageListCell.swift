import Foundation
import UIKit

//MARK: - class ImageListCell
final class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    @IBOutlet var likeButtonActive: UIButton!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var imageCell: UIImageView!
}


