

import Foundation
import UIKit


enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private var lastCode: String?
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        let urlString = "https://unsplash.com/oauth/token" +
        "?client_id=\(Constants.accessKey)" +
        "&client_secret=\(Constants.secretKey)" +
        "&redirect_uri=\(Constants.redirectURI)" +
        "&code=\(code)" +
        "&grant_type=authorization_code"
        
        guard let url = URL(string: urlString) else {
            print("Failed to create URL with baseURL and parameters.")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil {
            if lastCode != code {
                task?.cancel()
            } else {
                completion(.failure(AuthServiceError.invalidRequest))
                self.task = nil
                return
            }
        } else {
            if lastCode == code {
                completion(.failure(AuthServiceError.invalidRequest))
                return
            }
        }
        lastCode = code
        guard let request = makeOAuthTokenRequest(code: code)
        else {
            DispatchQueue.main.async{
                completion(.failure(AuthServiceError.invalidRequest))
            }
            return
        }
        task = urlSession.objectTask(for: request) { (result: Result<OAuthTokenResponseBody, Error>) in
            self.task = nil
            self.lastCode = nil
            switch result {
            case .success(let response):
                OAuth2TokenStorage.shared.token = response.accessToken
                print(response.accessToken)
                DispatchQueue.main.async {
                    completion(.success(response.accessToken))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}



