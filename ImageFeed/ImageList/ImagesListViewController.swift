import UIKit

final class ImagesListViewController: UIViewController {
    
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"

    @IBOutlet private weak var tableView: UITableView!
    
    private let photoNames: [String] = Array(0..<20).map{"\($0)"}
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == ShowSingleImageSegueIdentifier{
            let viewController = segue.destination as! SingleImageViewController
            let indexPatch = sender as! IndexPath
            let image = UIImage(named: photoNames[indexPatch.row])
            viewController.image = image

        }
        else{
            super.prepare(for: segue, sender: sender)
        }
    }
    override func viewDidLoad() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        super.viewDidLoad()
    }
    
}
// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    //Реализация из автоского проекта взята
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photoNames[indexPath.row]) else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
}
// MARK: - UITableViewDataSource
extension ImagesListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoNames.count //тут мы возвращаем количество фоток всего
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
}

extension ImagesListViewController{
    func configCell(for cell: ImagesListCell, with indexPatch: IndexPath){
        guard let image = UIImage(named: photoNames[indexPatch.row]) else {
            return
        }
        cell.cellImage.image = image
        cell.dataLabel.text = dateFormatter.string(from: Date())
        
        cell.cellImage.layer.cornerRadius = 16
        cell.cellImage.layer.masksToBounds = true
        
        /*задаем цвет грандиенту, пока не доделал, нет плавного перехода
        let gradient = CAGradientLayer()
        gradient.frame = cell.gradientView.bounds
        gradient.colors = [UIColor.ypGradientBlack00.cgColor, UIColor.ypGradientBlack20.cgColor]
        cell.gradientView.layer.insertSublayer(gradient, at: 0)
        */
        
        let isLiked = indexPatch.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "like") : UIImage(named: "like_no_active")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}




