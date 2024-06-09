//
//  File.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 01.06.2024.
//

import Foundation
import UIKit

final class AuthViewController: UIViewController{
    
    private let oauth2Service = OAuth2Service.shared
    private let AuthViewControllerID = "ShowWebView"
    
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    //...
}
/*
func makeOAuthTokenRequest(code: String) -> URLRequest{
    let baseUrl = URL(string: "https://unsplash.com")!
    let name = URL(string: "/oauth/token"
                   + "?client_id=\(accessKey)"
                   + "&&client_secret=\(secretKey)"
                   + "&&redirect_uri=\(redirectURI)"
                   + "&&code=\(code)"
                   + "&&grant_type=authorization_code",
    )!
}*/

extension AuthViewController: WebViewViewControllerDelegate{
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        //code
    }
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
