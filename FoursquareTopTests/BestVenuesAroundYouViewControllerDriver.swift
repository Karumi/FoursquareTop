import Foundation
@testable import FoursquareTop

class BestVenuesAroundYouViewControllerDriver {
    
    private let testCase: BaseUITestCase
    
    init(testCase: BaseUITestCase) {
        self.testCase = testCase
    }
    
    func expectLoading(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.Loading)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.Loading)
        }
    }
    
    func expectEmptyCase(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.VenuesListNoVenuesAroundYouError)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.VenuesListNoVenuesAroundYouError)
        }
    }
        
    func expectCanNotFetchLocationError(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchLocationError)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchLocationError)
        }
    }
    
    func expectCanNotFetchVenuesError(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchVenuesError)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.VenuesListCanNotFetchVenuesError)
        }
    }
    
    func tapRetry() {
        testCase.tapViewWithLocalizedAccessibilityLabel(.ErrorViewAccesibilityLabel)
    }
    
    func expectVenueList(list: VenueListViewModel) {
        let topVenue = list.venues.first!
        testCase.kifTester().waitForViewWithAccessibilityLabel(topVenue.name)
    }
    
    func expectGPSAlert(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.VenuesListNoGPSAccessErrorTitle)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.VenuesListNoGPSAccessErrorTitle)
        }
    }
    
    func tapGoToSettings() {
        testCase.tapViewWithLocalizedAccessibilityLabel(.VenuesListNoGPSAccessGoToGeneralSettings)
    }
    
    func tapTopVenue() {
        testCase.tapItemInCollectionViewWithAccessibilityIdentifier(
            "BestVenuesAroundYouAccesibilityLabel",
            atIndexPath: NSIndexPath(forItem: 0, inSection: 0)
        )
    }
    
    func tapCategory(atIndex index: Int) {
        testCase.tapItemInCollectionViewWithAccessibilityIdentifier(
            "BestVenuesAroundYouAccesibilityLabel",
            atIndexPath: NSIndexPath(forItem: index, inSection: 0)
        )
    }
}