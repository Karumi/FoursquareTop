
import Foundation
import Nimble
import KIF

@testable import FoursquareTop

class BestVenuesAroundYouViewControllerTests: BaseUITestCase {
    
    private var stubVenueListNavigator: StubVenueListNavigator!
    private var getUserLocationUseCase: StubGetUserLocationUseCase!
    private var getBestPlacesAroundYouUseCase: StubGetBestPlacesAroundYouUseCase!
    private var driver: BestVenuesAroundYouViewControllerDriver!
    
    override func setUp() {
        super.setUp()
        
        getUserLocationUseCase = StubGetUserLocationUseCase()
        getBestPlacesAroundYouUseCase = StubGetBestPlacesAroundYouUseCase()
        stubVenueListNavigator = StubVenueListNavigator()
        driver = BestVenuesAroundYouViewControllerDriver(testCase: self)
    }
    
    // MARK: Tests
    
    func testLoadingIndicatorIsVisibleWhenLoadingVenues() {
        getUserLocationUseCase.givenWeAreFetchingUsersLocation()
        
        openViewController()
        
        driver.expectLoading(toBeVisible: true)
    }
    
    func testErrorIsShownIfTheLocationCanNotBeDetermined() {
        getUserLocationUseCase.givenThereWillBeAnErrorFetchingUsersLocation()
        
        openViewController()
        
        driver.expectCanNotFetchLocationError(toBeVisible: true)
    }
    
    func testErrorIsShownIfTheVenuesCanNotBeFetched() {
        getBestPlacesAroundYouUseCase.givenThereWillBeAnErrorFetchingVenues()
        
        openViewController()
        
        driver.expectCanNotFetchVenuesError(toBeVisible: true)
    }
    
    func testRetryShowsVenuesAfterThereIsAnErrorFetchingVenues() {
        executeRetryTest(errorSetupBlock: { 
            self.getBestPlacesAroundYouUseCase.givenThereWillBeAnErrorFetchingVenues()
        }) {
            self.driver.expectCanNotFetchVenuesError(toBeVisible: false)
        }
    }
    
    func testRetryShowsVenuesAfterThereIsAnErrorFetchingUsersLocation() {
        executeRetryTest(errorSetupBlock: {
            self.getUserLocationUseCase.givenThereWillBeAnErrorFetchingUsersLocation()
        }) {
            self.driver.expectCanNotFetchLocationError(toBeVisible: false)
        }
    }
    
    func testAlertIsShownIfWeDontHaveAccessToTheGPS() {
        getUserLocationUseCase.givenWeCanNotAccessTheGPS()
        
        openViewController()
        
        driver.expectGPSAlert(toBeVisible: true)
    }
    
    func testSettingsIsOpenIfTheUserWantsToEnableTheGPS() {
        getUserLocationUseCase.givenWeCanNotAccessTheGPS()
        
        openViewController()
        driver.tapGoToSettings()
        
        expect(
            self.stubVenueListNavigator.didGoToSettings
        ).toEventually(
            equal(true)
        )
    }
    
    func testVenuesAreShownIfThereAreVenuesInTheUserLocation() {
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues()

        openViewController()
        
        driver.expectVenueList(getBestPlacesAroundYouUseCase.venueList!)
    }
    
    func testEmptyCaseIsShownIfThereAreNoVenuesInTheUserLocation() {
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues(venuesCount: 0)

        openViewController()
        
        driver.expectEmptyCase(toBeVisible: true)
    }
    
    func testNavigatesToVenueDetailIfTheTopVenueIsSelected() {
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues()
        
        openViewController()
        
        let topVenue = getBestPlacesAroundYouUseCase.venueList!.venues.first!
        
        driver.tapTopVenue()
        
        expect(self.stubVenueListNavigator.didGoToVenueDetail).toEventually(equal(true))
        expect(self.stubVenueListNavigator.venueDetail!.foursquareID).toEventually(equal(topVenue.foursquareID))
    }
    
    func testNavigatesToVenueDetailIfACategoryIsSelected() {
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues()
        
        openViewController()
        
        let index = 1 // This is really the fisrt category as the top venue is 0
        let categoryToTap = getBestPlacesAroundYouUseCase.venueList!.venues[index]
        
        driver.tapCategory(atIndex: index)
        
        expect(self.stubVenueListNavigator.didGoToVenueDetail).toEventually(equal(true))
        expect(self.stubVenueListNavigator.venueDetail!.primaryCategory.identifier).toEventually(equal(categoryToTap.primaryCategory.identifier))
    }
    
    // MARK: Private
    
    override func presentViewController(window: UIWindow, navigator: RootNavigator, appCompositionRoot: AppCompositionRoot) {

        presentViewController(
            appCompositionRoot.venue.getBestVenuesAroundViewController()
        )
    }
    
    override func getTestingAppCompositionRoot(compositionRoot: AppCompositionRoot) -> AppCompositionRoot {
        return AppCompositionRoot.Builder()
            .with(venueCompositionRoot: getVenueCompositionRoot())
            .build()
    }
    
    private func getVenueCompositionRoot() -> VenueCompositionRoot {
        let venueCompositionRoot = TestingVenueCompositionRoot()
        venueCompositionRoot.stubGetUserLocationUseCase = getUserLocationUseCase
        venueCompositionRoot.stubGetBestPlacesAroundYouUseCase = getBestPlacesAroundYouUseCase
        venueCompositionRoot.stubVenueListNavigator = stubVenueListNavigator
        return venueCompositionRoot
    }
    
    private func executeRetryTest(errorSetupBlock block: () -> (), noErrorIsVisibleBlock noErrorBlock: () -> ()) {
        block()
        
        openViewController()
        
        getUserLocationUseCase.error = nil
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues()
        
        driver.tapRetry()
        driver.expectVenueList(getBestPlacesAroundYouUseCase.venueList!)
        
        noErrorBlock()
    }
}
