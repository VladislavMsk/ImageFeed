import Foundation
import UIKit

//MARK: - protocol AuthViewControllerDelegate
protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}

//MARK: - AuthViewController
final class AuthViewController: UIViewController, WebViewViewControllerDelegate {
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private let oauth2Service = OAuth2Service.shared
    weak var delegate: AuthViewControllerDelegate?
    private let showWebViewSegue = "ShowWebView"
    @IBOutlet var authLogo: UIImageView!
    @IBOutlet var enterButton: UIButton!
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        vc.dismiss(animated: true)
        oauth2Service.fetchAuthToken(code: code) { result in
            switch result {
            case .success(let token):
                self.oauth2TokenStorage.token = token
                self.delegate?.didAuthenticate(self)
            case .failure(let error):
                print("Failed to fetch OAuth token with error: \(error)")
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "navBackButton")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navBackButton")
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
}

extension AuthViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegue {
            guard let viewController  = segue.destination as? WebViewViewController else {
                print("segue.destination as! WebViewViewController не смог преобразовать")
                return
            }
            viewController.authViewDelegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}





