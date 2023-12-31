//
//  ViewController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 29.11.2023.
//

import UIKit

extension ImagesListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        let isLiked = indexPatch.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "like") : UIImage(named: "like_no_active")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}

class ImagesListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    private let photoNames: [String] = Array(0..<20).map{"\($0)"}
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        //tableView.dataSource = self
        //tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        //Задаем скругление у ячейки таблицы
        //ImagesListCell.layer.cornerRadius = 16
        //ImagesListCell.layer.masksToBounds = TRUE
        //CellImage.layer.cornerRadius = 16
        //CellImage.layer.masksToBounds = true
        
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

