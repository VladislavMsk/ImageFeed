import UIKit

//MARK: - class ImageListViewController
final class ImageListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private let photosName: [String] = Array(0..<20).map{("\($0)")}
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let imageName = photosName[indexPath.row]
            let image = UIImage(named: "\(imageName)_full_size") ?? UIImage(named: imageName)
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    private lazy var dateFormated: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        //formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}

//MARK: - extension ImageListViewController
extension ImageListViewController {
    func configCell(for cell: ImageListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        cell.imageCell.image = image
        cell.dataLabel.text = dateFormated.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        let likedImage = isLiked ? UIImage(named: "Icon 42x42 ActiveLike") : UIImage(named: "Icon 42x42 NoActiveLike1")
        cell.likeButtonActive.setImage(likedImage, for: .normal)
    }
    
}

//MARK: - extension ImageListViewController
extension ImageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
}

//MARK: - extension ImageListViewController
extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseIdentifier, for: indexPath)
        guard let imageListcell = cell as? ImageListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListcell, with: indexPath)
        return imageListcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeidht = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeidht
        
        
    }
}


