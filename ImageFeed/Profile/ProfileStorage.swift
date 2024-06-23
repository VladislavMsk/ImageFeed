import Foundation
import SwiftKeychainWrapper

//MARK: - class ProfileStorage
final class ProfileStorage {
    var userName: String {
        get {
            return UserDefaults.standard.string(forKey: "userName") ?? "There is no name"        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
    var firstName: String {
        get {
            return UserDefaults.standard.string(forKey: "firstName") ?? "There is no firstName"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstName")
        }
    }
    var lastName: String {
        get {
            return UserDefaults.standard.string(forKey: "lastName") ?? "There is no lastName"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastName")
        }
    }
    var bio: String {
        get {
            return UserDefaults.standard.string(forKey: "bio") ?? "There is no bio"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bio")
        }
    }
}
