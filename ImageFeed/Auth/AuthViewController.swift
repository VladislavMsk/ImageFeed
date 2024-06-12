//
//  File.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 01.06.2024.
//

import Foundation
import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"

    weak var delegate: AuthViewControllerDelegate?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

/*
final class OAuth2Service {
    static let shared = OAuth2Service()
    
    private let urlSession = URLSession.shared
    
    private (set) var authToken: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
*/
    private struct OAuthTokenResponseBody: Codable {
            let accessToken: String
            let tokenType: String
            let scope: String
            let createdAt: Int
            
            enum CodingKeys: String, CodingKey {
                case accessToken = "access_token"
                case tokenType = "token_type"
                case scope
                case createdAt = "created_at"
            }

    
    func fetchAuthToken(_ code: String, complention: @escaping (Result<String, Error>) -> Void) {
        let request = makeRequest(code: code)
        let task = object(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                complention(.success(authToken))
            case .failure(let error):
                complention(.failure(error))
            }
        }
        task.resume()
    }
}

func makeOAuthTokenRequest(code: String) -> URLRequest{
    let baseUrl = URL(string: "https://unsplash.com")!
    let url = URL(string: "/oauth/token"
                  + "?client_id=\(Constants.accessKey)"
                  + "&&client_secret=\(Constants.secretKey)"
                  + "&&redirect_uri=\(Constants.redirectURI)"
                   + "&&code=\(code)"
                   + "&&grant_type=authorization_code",
                   relativeTo: baseUrl
    )!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request

}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }

    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
