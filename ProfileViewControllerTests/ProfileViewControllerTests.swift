import XCTest
@testable import ImageFeed

final class ProfileViewControllerTests: XCTestCase {
    
    func testViewDidLoadCallsPresenter() {
        let viewController = MockProfileViewController()
        let presenter = MockProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
        XCTAssertTrue(presenter.fetchProfileCalled)
        XCTAssertTrue(viewController.showProfileDetailsCalled)
    }
    
    func testFetchProfileSuccess() {
        let viewController = MockProfileViewController()
        let presenter = MockProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.fetchProfile()
        
        XCTAssertEqual(viewController.nameLabel.text, "John Doe")
        XCTAssertEqual(viewController.loginLabel.text, "@johndoe")
        XCTAssertEqual(viewController.descriptionLabel.text, "Test bio")
    }
    
    func testUpdateAvatar() {
        let viewController = MockProfileViewController()
        let presenter = MockProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        let imageURL = URL(string: "https://example.com/profile.jpg")!
        presenter.updateAvatarURL(imageURL)
        
        viewController.showProfileImage(url: imageURL)
        
        XCTAssertTrue(viewController.showProfileImageCalled)
    }
    
    func testDidTapLogoutButton() {
        let viewController = MockProfileViewController()
        let presenter = MockProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.didTapLogoutButton()
        
        XCTAssertTrue(presenter.logoutCalled)
        XCTAssertTrue(viewController.showLogoutConfirmationCalled)
    }
}
