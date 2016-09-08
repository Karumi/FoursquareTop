
import Foundation
import UIKit
@testable import FoursquareTop

class BestVenuesAroundYouViewControllerNavigationTests: BaseUITestCase {
    
    private var getUserLocationUseCase: StubGetUserLocationUseCase!
    private var getBestPlacesAroundYouUseCase: StubGetBestPlacesAroundYouUseCase!
    private var getVenueDetailsUseCase: StubGetVenueDetailsUseCase!
    private var listDriver: BestVenuesAroundYouViewControllerDriver!
    private var detailDriver: VenueDetailViewControllerDriver!
    
    override func setUp() {
        super.setUp()
        
        getUserLocationUseCase = StubGetUserLocationUseCase()
        getBestPlacesAroundYouUseCase = StubGetBestPlacesAroundYouUseCase()
        getVenueDetailsUseCase = StubGetVenueDetailsUseCase()
        listDriver = BestVenuesAroundYouViewControllerDriver(testCase: self)
        detailDriver = VenueDetailViewControllerDriver(testCase: self)
    }
    
    // MARK: Tests
    
    func testNavigatesToVenueDetailWhenUserTapsOnVenue() {
        getBestPlacesAroundYouUseCase.givenThereWillBeVenues(venuesCount: 10, categoryCount: 1)
        
        let topVenue = getBestPlacesAroundYouUseCase.venueList!.venues.first!
        getVenueDetailsUseCase.venue = topVenue
        
        openViewController()
        
        listDriver.tapTopVenue()
        
        detailDriver.expectTitle(ofVenue: topVenue, toBeVisible: true)
    }
    
    // MARK: Private
    override func presentViewController(window: UIWindow, navigator: RootNavigator, appCompositionRoot: AppCompositionRoot) {
        navigator.installRootViewController(window)
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
        venueCompositionRoot.stubGetVenueDetailsUseCase = getVenueDetailsUseCase
        return venueCompositionRoot
    }
}