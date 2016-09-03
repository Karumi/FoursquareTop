
import UIKit
import KIF
@testable import FoursquareTop

class BaseUITestCase: KIFTestCase {
    
    private var rootNavigator: RootNavigator!
    
    var rootViewController: UINavigationController {
        return self.rootNavigator.currentlyPresentedNavigationController!
    }
    
    private var keyWindow: UIWindow {
        return UIApplication.sharedApplication().keyWindow!
    }
    
    func openViewController() {
        let appCompositionRoot = getTestingAppCompositionRoot(
            baseAppCompositionRoot
        )
        rootNavigator = RootNavigator(
            appCompositionRoot: appCompositionRoot
        )
        
        presentViewController(
            keyWindow,
            navigator: rootNavigator,
            appCompositionRoot: appCompositionRoot
        )
        
        kifTester().waitForAnimationsToFinish()
    }
    
    func presentViewController(window: UIWindow, navigator: RootNavigator, appCompositionRoot: AppCompositionRoot) {
        fatalError("Implement this method on your UI tests")
    }
    
    func presentViewController(viewController: UIViewController) {
        keyWindow.setRootViewController(viewController)
    }
    
    func getTestingAppCompositionRoot(compositionRoot: AppCompositionRoot) -> AppCompositionRoot {
        return baseAppCompositionRoot
    }
    
    private var baseAppCompositionRoot: AppCompositionRoot {
        return AppCompositionRoot.Builder()
            .with(venueCompositionRoot: TestingVenueCompositionRoot())
            .build()
    }
}

// This avoid the creation of multiple UITransitionView hanging from UIWindow that can occasionally keep two ViewControllers
// in the hierarchy
private extension UIWindow {
    
    /// Fix for http://stackoverflow.com/a/27153956/849645
    func setRootViewController(newRootViewController: UIViewController, transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.addAnimation(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled() {
            UIView.animateWithDuration(CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKindOfClass(transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismissViewControllerAnimated(false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}