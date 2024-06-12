//
//  File.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 11.06.2024.
//

import Foundation

final class OAuth2Service {
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("")) // TODO [Sprint 10]
    }
}
