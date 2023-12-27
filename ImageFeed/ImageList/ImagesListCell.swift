import UIKit

final class ImagesListCell: UITableViewCell{
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
}
