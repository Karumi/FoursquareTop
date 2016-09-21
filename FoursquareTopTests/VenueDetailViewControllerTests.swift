
import UIKit

@testable import FoursquareTop

class VenueDetatilViewControllerTests : BaseUITestCase {
    
    private var getVenueDetailsUseCase : StubGetVenueDetailsUseCase!
    private var driver : VenueDetailViewControllerDriver!
    
    override func setUp() {
        super.setUp()
        
        getVenueDetailsUseCase = StubGetVenueDetailsUseCase()
        driver = VenueDetailViewControllerDriver(testCase: self)
    }
    
    // MARK: Tests
    
    func testLoadingDoesntDisappearIfThereIsNoVenue() {
        getVenueDetailsUseCase.givenNoVenue()
        
        openViewController()
        
        driver.expectLoading(toBeVisible: true)
    }
    
    func testLoadingDisappearWhenThereIsAVenue() {
        getVenueDetailsUseCase.givenAVenue()
        
        openViewController()
        
        driver.expectLoading(toBeVisible: false)
    }
    
    func testMenuButtonIsNotVisibleWhenVenueHasNoMenu() {
        getVenueDetailsUseCase.givenVenue(withMenu : nil)
        
        openViewController()
        
        driver.expectMenuButton(toBeVisible: false)
    }
    
    func testMenuButtonIsVisibleWhenVenueHasMenu() {
        getVenueDetailsUseCase.givenVenue(withMenu: NSURL(fileURLWithPath: "http://www.karumi.com"))
        
        openViewController()
        
        driver.expectMenuButton(toBeVisible: true)
    }
    
    func testAddressIsVisibleIfVenueHasAny() {
        getVenueDetailsUseCase.givenAVenue(withAddress: "Karumi HQ")
        
        openViewController()
        
        driver.expectAddressLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: true)
    }
    
    func testAddressIsNotVisibleIfVenueHasNone() {
        getVenueDetailsUseCase.givenAVenue(withAddress: nil)
        
        openViewController()
        
        driver.expectAddressLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: false)
    }
    
    func testStatusIsVisibleIfVenueHasAny() {
        getVenueDetailsUseCase.givenAVenue(withStatus: "Open 24/7")
        
        openViewController()
        
        driver.expectStatusLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: true)
    }
    
    func testStatusIsNotVisibleIfVenueHasNone() {
        getVenueDetailsUseCase.givenAVenue(withStatus: nil)
        
        openViewController()
        
        driver.expectStatusLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: false)
    }
    
    func testRatingIsVisibleIfVenueHasAny() {
        getVenueDetailsUseCase.givenAVenue(withRating: 5.0)
        
        openViewController()
        
        driver.expectRatingLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: true)
    }
    
    func testRatingIsNotVisibleIfVenueHasNone() {
        getVenueDetailsUseCase.givenAVenue(withRating: nil)
        
        openViewController()
        
        driver.expectRatingLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: false)
    }
    
    func testPricingIsVisibleIfVenueHasAny() {
        getVenueDetailsUseCase.givenAVenue(withPrice: .Expensive)
        
        openViewController()
        
        driver.expectPricingLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: true)
    }
    
    func testPricingIsNotVisibleIfVenueHasNone() {
        getVenueDetailsUseCase.givenAVenue(withPrice: nil)
        
        openViewController()
        
        driver.expectPricingLabel(ofVenue: getVenueDetailsUseCase.venue!, toBeVisible: false)
    }

    // MARK: Private
    override func presentViewController(window: UIWindow, navigator: RootNavigator, appCompositionRoot: AppCompositionRoot) {
    
        presentViewController(
            appCompositionRoot.venue.getVenueDetailViewController("", forIndex: 0)
        )
    
    }
    
    override func getTestingAppCompositionRoot(compositionRoot: AppCompositionRoot) -> AppCompositionRoot {
        return AppCompositionRoot.Builder()
        .with(venueCompositionRoot: getVenueCompositionRoot())
        .build()
    }
    
    private func getVenueCompositionRoot() -> VenueCompositionRoot {
        let venueCompositionRoot = TestingVenueCompositionRoot()
        venueCompositionRoot.stubGetVenueDetailsUseCase = getVenueDetailsUseCase
        return venueCompositionRoot
    }
}
