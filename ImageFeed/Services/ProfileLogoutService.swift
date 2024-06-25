import Foundation
import WebKit

//MARK: - class ProfileLogoutService
final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    
    private init() { }
    private let profileService = ProfileService.shared
    private let imagesListService = ImagesListService()
    private let profileImageService = ProfileImageService.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    func logout() {
        cleanCookies()
        cleanOAuth2TokenStorage()
        cleanProfileService()
        cleanImagesListService()
        cleanProfileImage()
        
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func cleanProfileService() {
        self.profileService.cleanProfile()
    }
    private func cleanImagesListService(){
        self.imagesListService.cleanImagesList()
    }
    private func cleanProfileImage() {
        self.profileImageService.cleanProfileImage()
    }
    private func cleanOAuth2TokenStorage() {
        self.oAuth2TokenStorage.cleanOAuthToken()
    }
}

