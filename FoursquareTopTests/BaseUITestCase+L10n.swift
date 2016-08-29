import Foundation
import KIF
@testable import FoursquareTop

extension BaseUITestCase {
    
    func waitForViewWithLocalizedAccessibilityLabel(key: L10n) -> UIView {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        return kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func waitForViewWithLocalizedAccessibilityLabel(key: L10n, traits:UIAccessibilityTraits) -> UIView {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        return kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel, traits: traits)
    }
    
    func waitForAbsenceOfViewWithLocalizedAccessibilityLabel(key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().waitForAbsenceOfViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func tapViewWithLocalizedAccessibilityLabel(key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().tapViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func tapViewWithLocalizedAccessibilityLabel(key: L10n, traits: UIAccessibilityTraits) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().tapViewWithAccessibilityLabel(localizedAccessibilityLabel, traits: traits)
    }
    
    func enterText(text: String, intoViewWithLocalizedAccessibilityLabelKey key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().enterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel)
    }
    
    func enterText(text: String, traits:(UIAccessibilityTraits), expectedResult:String, intoViewWithLocalizedAccessibilityLabelKey key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().enterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel, traits: traits, expectedResult: expectedResult)
    }
    
    func clearTextFromAndThenEnterText(text: String, intoViewWithLocalizedAccessibilityLabelKey key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().clearTextFromAndThenEnterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel)
    }
    
    func clearText(inViewWithLocalizedAccessibilityLabelKey key: L10n) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().clearTextFromViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func pullToRefreshViewWithLocalizedAccessibilityLabel(key: L10n, pullDownDuration: KIFPullToRefreshTiming) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().pullToRefreshViewWithAccessibilityLabel(localizedAccessibilityLabel, pullDownDuration: pullDownDuration)
    }
    
    func swipeViewWithLocalizedAccessibilityLabel(key: L10n, inDirection: KIFSwipeDirection) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        kifTester().swipeViewWithAccessibilityLabel(localizedAccessibilityLabel, inDirection: inDirection)
    }
    
    func waitForViewOutsideTheScreenWithLocalizedAccessibilityLabel(key: L10n) -> UIView  {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key)
        let view = kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel)
        
        if !UIScreen.mainScreen().bounds.contains(view.frame) {
            kifTester().fail()
        }
        
        return view
    }
    
    private func getLocalizedAccessibilityLabel(key: L10n) -> String {
        return tr(key)
    }
}