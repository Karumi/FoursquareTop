import Foundation
@testable import FoursquareTop

class VenueDetailViewControllerDriver {
    
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
    
    func expectTitle(ofVenue venue: VenueViewModel, toBeVisible visible: Bool) {
        let tester = testCase.kifTester()
        let name = venue.name
        let categoryName = venue.primaryCategory.names.get(forType: .Short)
        if visible {
            tester.waitForViewWithAccessibilityLabel(name)
            tester.waitForViewWithAccessibilityLabel(categoryName)
        } else {
            tester.waitForAbsenceOfViewWithAccessibilityLabel(name)
            tester.waitForAbsenceOfViewWithAccessibilityLabel(categoryName)
        }
    }
}