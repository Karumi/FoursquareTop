
import Foundation
import Nimble
import KIF
import Nocilla

@testable import FoursquareTop

class BestVenuesAroundYouViewControllerTests: BaseUITestCase {
    
    private var getUserLocationUseCase: StubGetUserLocationUseCase!
    private var getBestPlacesAroundYouUseCase: StubGetBestPlacesAroundYouUseCase!
    
    override func setUp() {
        super.setUp()
        
        getUserLocationUseCase = StubGetUserLocationUseCase()
        getBestPlacesAroundYouUseCase = StubGetBestPlacesAroundYouUseCase()
    }
    
    // MARK: Tests
    
    func testLoadingIndicatorIsVisibleWhenLoadingVenues() {
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
    
    func testRetryShowsVenuesAfterThereIsAnErrorFetchingVenues() {
    
    }
    
    func testRetryShowsVenuesAfterThereIsAnErrorFetchingUsersLocation() {
        
    }
    
    func testAlertIsShownIfWeDontHaveAccessToTheGPS() {
        
    }
    
    func testSettingsIsOpenIfTheUserWantsToEnableTheGPS() {
        
    }
    
    func testVenuesAreShownIfThereAreVenuesInTheUserLocation() {
        
    }
    
    func testEmptyCaseIsShownIfThereAreNoVenuesInTheUserLocation() {
        
    }
    
    func testTopVenueIsShown() {
        
    }
    
    func testVenuesOfOtherCategoriesAreShown() {
        
    }
    
    func testNavigatesToVenueDetailIfTheTopVenueIsSelected() {
        
    }
    
    func testNavigatesToVenueDetailIfACategoryIsSelected() {
        
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
    
    override func presentViewController(window: UIWindow, navigator: RootNavigator, appCompositionRoot: AppCompositionRoot) {

        presentViewController(
            appCompositionRoot.venue.getBestVenuesAroundViewController()
        )
    }
    
    override func getTestingAppCompositionRoot(compositionRoot: AppCompositionRoot) -> AppCompositionRoot {
        return AppCompositionRoot.Builder(compositionRoot: compositionRoot)
            .with(venueCompositionRoot: getVenueCompositionRoot())
            .build()
    }
    
    private func getVenueCompositionRoot() -> VenueCompositionRoot {
        let venueCompositionRoot = TestingVenueCompositionRoot()
        venueCompositionRoot.stubGetUserLocationUseCase = getUserLocationUseCase
        venueCompositionRoot.stubGetBestPlacesAroundYouUseCase = getBestPlacesAroundYouUseCase
        return venueCompositionRoot
    }
}
