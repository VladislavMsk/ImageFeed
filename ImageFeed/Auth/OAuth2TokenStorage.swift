import Foundation
import SwiftKeychainWrapper

//MARK: - class OAuth2TokenStorage
final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private init() {}
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "OAuth2Token")
        }
        set {
            let isSuccess = KeychainWrapper.standard.set(newValue ?? "there is no token for saving in Storage ", forKey: "OAuth2Token")
            guard isSuccess else {
                print("Error. Token is absent")
                return
            }
        }
    }
    func cleanOAuthToken() {
        self.token = nil
    }
}
