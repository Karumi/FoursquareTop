import Foundation
import KIF

extension BaseUITestCase {
    
    func waitForViewWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = []) -> UIView {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        return kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func waitForViewWithLocalizedAccessibilityLabel(key: String, traits:UIAccessibilityTraits, arguments: [CVarArgType] = []) -> UIView {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        return kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel, traits: traits)
    }
    
    func waitForAbsenceOfViewWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().waitForAbsenceOfViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func tapViewWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().tapViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func tapViewWithLocalizedAccessibilityLabel(key: String, traits: UIAccessibilityTraits, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().tapViewWithAccessibilityLabel(localizedAccessibilityLabel, traits: traits)
    }
    
    func tapItemInCollectionViewWithAccessibilityIdentifier(accessibilityIdentifier: String, atIndexPath indexPath: NSIndexPath) {
        kifTester().tapItemAtIndexPath(indexPath, inCollectionViewWithAccessibilityIdentifier: accessibilityIdentifier)
    }
    
    func enterText(text: String, intoViewWithLocalizedAccessibilityLabelKey key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().enterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel)
    }
    
    func enterText(text: String, traits:(UIAccessibilityTraits), expectedResult:String, intoViewWithLocalizedAccessibilityLabelKey key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().enterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel, traits: traits, expectedResult: expectedResult)
    }
    
    func clearTextFromAndThenEnterText(text: String, intoViewWithLocalizedAccessibilityLabelKey key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().clearTextFromAndThenEnterText(text, intoViewWithAccessibilityLabel: localizedAccessibilityLabel)
    }
    
    func clearText(inViewWithLocalizedAccessibilityLabelKey key: String, arguments: [CVarArgType] = []) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().clearTextFromViewWithAccessibilityLabel(localizedAccessibilityLabel)
    }
    
    func pullToRefreshViewWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = [], pullDownDuration: KIFPullToRefreshTiming) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().pullToRefreshViewWithAccessibilityLabel(localizedAccessibilityLabel, pullDownDuration: pullDownDuration)
    }
    
    func swipeViewWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = [], inDirection: KIFSwipeDirection) {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        kifTester().swipeViewWithAccessibilityLabel(localizedAccessibilityLabel, inDirection: inDirection)
    }
    
    func waitForViewOutsideTheScreenWithLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType] = []) -> UIView  {
        let localizedAccessibilityLabel = getLocalizedAccessibilityLabel(key, arguments: arguments)
        let view = kifTester().waitForViewWithAccessibilityLabel(localizedAccessibilityLabel)
        
        if !UIScreen.mainScreen().bounds.contains(view.frame) {
            kifTester().fail()
        }
        
        return view
    }
    
    private func getLocalizedAccessibilityLabel(key: String, arguments: [CVarArgType]) -> String {
        return String(format: NSLocalizedString(key, comment: ""), arguments: arguments)
    }
}