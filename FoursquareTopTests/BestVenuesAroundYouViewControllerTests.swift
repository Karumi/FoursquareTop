
import Foundation
import Nimble
import KIF
import Nocilla

@testable import FoursquareTop

class BestVenuesAroundYouViewControllerTests: BaseUITestCase {
    
    private var getUserLocationUseCase = StubGetUserLocationUseCase()
    private var getBestPlacesAroundYouUseCase = StubGetBestPlacesAroundYouUseCase()
    
    // MARK: Tests
    
    func testLoadingIndicatorIsVisibleWhenLoadingAds() {
        givenWeAreFetchingUsersLocation()
        
        openViewController()
        
        waitForViewWithLocalizedAccessibilityLabel(.Loading)
    }
    
    func testErrorIsShownIfTheLocationCanNotBeDetermined() {
        givenThereWillBeAnErrorFetchingUsersLocation()
        
        openViewController()
        
        waitForViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchLocationError)
    }
    
    func testErrorIsShownIfTheVenuesCanNotBeFetched() {
        givenThereWillBeAnErrorFetchingVenues()
        
        openViewController()
        
        waitForViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchVenuesError)
    }
    
    // MARK: Given
    
    func givenThereWillBeAnErrorFetchingVenues() {
        getBestPlacesAroundYouUseCase.error = .Generic
    }
    
    func givenWeAreFetchingUsersLocation() {
        getUserLocationUseCase.location = nil
    }
    
    func givenThereWillBeAnErrorFetchingUsersLocation() {
        getUserLocationUseCase.error = .CanNotFetch
    }
    
    func givenWeCanNotAccessTheGPS() {
        getUserLocationUseCase.error = .NoGPSAccess
    }
    
    // MARK: Private
    
    override func presentViewController(window: UIWindow, navigator: RootNavigator, serviceLocator: RootServiceLocator) {

        presentViewController(
            serviceLocator.venue.getBestVenuesAroundViewController()
        )
    }
    
    override func getTestingServiceLocator(serviceLocator: RootServiceLocator) -> RootServiceLocator {
        return RootServiceLocator.Builder(serviceLocator: serviceLocator)
            .with(venueServiceLocator: getVenueServiceLocator())
            .build()
    }
    
    private func getVenueServiceLocator() -> VenueServiceLocator {
        let serviceLocator = TestingVenueServiceLocator()
        serviceLocator.stubGetUserLocationUseCase = getUserLocationUseCase
        serviceLocator.stubGetBestPlacesAroundYouUseCase = getBestPlacesAroundYouUseCase
        return serviceLocator
    }
}
