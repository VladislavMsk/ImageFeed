import Foundation
import UIKit
import Kingfisher

//MARK: - class ImageListCell
final class ImageListCell: UITableViewCell {
    @IBOutlet var likeButtonActive: UIButton!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var imageCell: UIImageView!
    
    weak var delegate: ImagesListCellDelegate?
    var indexPath = IndexPath()
    static let reuseIdentifier = "ImageListCell"
    
    private let isLikedImage = UIImage(named: "Icon 42x42 ActiveLike")
    private let isNotLikedImage = UIImage(named: "Icon 42x42 NoActiveLike1")
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.kf.cancelDownloadTask()
        imageCell.image = nil
    }
    
    func setIsLiked(isLike: Bool?) {
        let imageLike = isLike ?? true ? "Icon 42x42 ActiveLike" : "Icon 42x42 NoActiveLike1"
        likeButtonActive.setImage(UIImage(named: imageLike), for: .normal)
    }
    
    @IBAction func didTapLikeButton(_ sender: Any) {
        delegate?.imagesListCellDidTapLike(self)
    }
}

//MARK: - protocol ImagesListCellDelegate
protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImageListCell)
}

