//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 17.06.2024.
//

import Foundation
import SwiftKeychainWrapper


struct ProfileResult: Codable {
    var userName: String
    var firstName: String?
    var lastName: String?
    var bio: String?
    
    
    private enum CodingKeys: String, CodingKey{
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}

struct UserResult: Codable {
    var profileImage: ProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage : Codable {
    var small: String?
    var medium: String?
    var large: String?
    
    private enum CodingKeys: String, CodingKey {
        case small = "small"
        case medium = "medium"
        case large = "large"
        
    }
}

struct Profile {
    var username: String
    var name: String
    var loginName: String
    var bio: String?
}

extension Profile {
    
    init(profileResult: ProfileResult) {
        self.init(
            username: profileResult.userName,
            name: "\(profileResult.firstName ?? "no data firstName")" + " " + "\(profileResult.lastName ?? "no data lastName")",
            loginName: "@" + "\(profileResult.userName)",
            bio: profileResult.bio ?? "no bio"
        )
    }
    
}


final class ProfileStorage {
    var userName: String {
        get {
            // Возвращаем сохраненное значение имени пользователя из UserDefaults
            return UserDefaults.standard.string(forKey: "userName") ?? "There is no name"
            // KeychainWrapper.standard.removeAllKeys()
        }
        set {
            // При установке нового значения имени пользователя сохраняем его в UserDefaults
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


final class ProfileImageService {
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var token = OAuth2TokenStorage.shared.token
    static let shared = ProfileImageService()
    init() {}
    private (set) var profileImageURL: String?
    private var profileImage = ProfileImage()
    private var profileService = ProfileService.shared
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    
    
    private func makeProfileImageRequest() -> URLRequest? {
        guard let userName = profileService.profile?.username else {
            print("No user name to create a request for fetch profileImage")
            return nil
        }
        
        let urlString = "https://api.unsplash.com/users/\(userName)"
        
        guard let url = URL(string: urlString) else {
            print("Failed to create URL with baseURL and parameters.")
            return nil
        }
        var request = URLRequest(url: url)
        
        let token = OAuth2TokenStorage.shared.token
        if token != nil {
            request.setValue("Bearer \(token ?? "her vam a ne token")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            print(request)
            return request
        }
        else { print("no token to make request") }
        return nil
    }
    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard let request1 = makeProfileImageRequest()else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        task = urlSession.objectTask(for: request1) { [weak self] (result: Result<UserResult, Error>) in
            switch result {
            case .success(let response):
                print("\(response.profileImage.small)")
                guard let profileImageURL = response.profileImage.small else {return}
                self?.profileImageURL = profileImageURL
                print("\(String(describing: profileImageURL))")
                DispatchQueue.main.async {
                    completion(.success(profileImageURL))
                    NotificationCenter.default.post (
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": profileImageURL]
                    )
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("\(result)")
                    print("\(error)")
                    completion(.failure(error))
                }
            }
        }
        
    }
}

