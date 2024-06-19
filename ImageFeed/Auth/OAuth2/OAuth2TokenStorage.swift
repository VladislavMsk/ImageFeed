//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 20.06.2024.
//

import Foundation
import SwiftKeychainWrapper


final class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    
    var token: String? {
        get {
            
            return KeychainWrapper.standard.string(forKey: "OAuth2Token")
        }
        set {
            // При установке нового значения токена сохраняем его в хранилище Keychain
            let isSuccess = KeychainWrapper.standard.set(newValue ?? "there is no token for saving in Storage ", forKey: "OAuth2Token")
            guard isSuccess else {
                print("Error. Token is absent")
                return
            }
        }
    }
}
