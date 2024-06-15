//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 27.12.2023.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    
    @IBOutlet private var singleImage: UIImageView! //если убрать private, код работает
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage! {
        didSet {
            guard isViewLoaded else {return}
            singleImage.image = image
            singleImage.frame.size = image.size
            rescaleAndCenterImageInScrollView(image: image)
            
        }
    }
    // MARK: rescaleAndCenterImageInScrollView()
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale  = 0.1
        scrollView.maximumZoomScale = 1.5
        singleImage.image = image
        rescaleAndCenterImageInScrollView(image: image)
        
    }
    
    //MARK: didTapBackButton()
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    //MARK: didTapShareButton()
    @IBAction private func didTapShareButton(){

        guard let image = image else{
            print("Не смогли получить изображение для кнопки. Ошибка в функции didTapShareButton")
            return
        }
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }
}

//MARK: - UIScrollViewDelegate
extension SingleImageViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        singleImage
    }
}
