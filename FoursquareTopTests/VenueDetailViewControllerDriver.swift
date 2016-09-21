import Foundation
import UIKit

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
    
    func expectMenuButton(toBeVisible visible: Bool) {
        if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(.VenueDetailSeeMenu)
        } else {
            testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(.VenueDetailSeeMenu)
        }
    }
    
    func expectAddressLabel(ofVenue venue: VenueViewModel, toBeVisible visible: Bool) {
        
        expectView(withText: venue.address, withAccessibilityLabel: tr(.VenueDetailAddressAccessibilityLabel), toBeVisible: visible)
        
    }
    
    func expectStatusLabel(ofVenue venue: VenueViewModel, toBeVisible visible: Bool) {
        
        expectView(withText: venue.status, withAccessibilityLabel: tr(.VenueDetailStatusAccessibilityLabel), toBeVisible: visible)
      
    }
    
    func expectRatingLabel(ofVenue venue: VenueViewModel, toBeVisible visible: Bool) {
        
        expectView(withText: venue.formattedRating, withAccessibilityLabel: tr(.VenueDetailRatingAccessibilityLabel), toBeVisible: visible)
        
    }
    
    func expectPricingLabel(ofVenue venue: VenueViewModel, toBeVisible visible: Bool)
    {
        expectView(withText: venue.formattedPrice, withAccessibilityLabel: tr(.VenueDetailPricingAccessibilityLabel), toBeVisible: visible)
    }
    
    private func expectView(withText text: String? = nil, withAccessibilityLabel label: String? = nil, toBeVisible visible: Bool) {
        
        if let accessibilityLabel = label {
            if visible {
                let view = testCase.waitForViewWithLocalizedAccessibilityLabel(accessibilityLabel) as UIView
                
                if let label = view as? UILabel {
                    failIfNotEqual(label.text!, expected: text!)
                } else if let button = view as? UIButton {
                    failIfNotEqual(button.titleLabel!.text!, expected: text!)
                } else {
                    testCase.failWithException(NSException(name: "Unknown UIView", reason: "Trying to find text in an UIView that may not contain text", userInfo: nil), stopTest: false)
                }
            } else {
                testCase.waitForAbsenceOfViewWithLocalizedAccessibilityLabel(accessibilityLabel)
            }
        } else if visible {
            testCase.waitForViewWithLocalizedAccessibilityLabel(text!)
        }
        
    }
    
    private func failIfNotEqual(value: String?, expected: String?) {
        if value! != expected! {
            testCase.failWithException(NSException(name: "Matching error", reason: "Text is not matching", userInfo: nil), stopTest: false)
        }
    }
}
