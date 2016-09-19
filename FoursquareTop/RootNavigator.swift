
import UIKit

enum ApplicationSections : Int {
    case List, Detail, Photos
}

enum ShortcutIdentifier: String {
    case BestVenuesAroundMe
}


class RootNavigator : NSObject {
    
    var currentNavigationController: UINavigationController?
    var currentlyPresentedViewController: UIViewController? {
        return currentNavigationController?.presentedViewController
    }
    var currentlyPresentedNavigationController: UINavigationController? {
        return currentNavigationController?.presentedViewController as? UINavigationController
    }
    let appCompositionRoot: AppCompositionRoot
    
    init(appCompositionRoot: AppCompositionRoot) {
        self.appCompositionRoot = appCompositionRoot
        
        super.init()
        
        appCompositionRoot.venue.navigator = self
    }
    
    func installRootViewController(window: UIWindow) {
        let vc = appCompositionRoot.getInitialViewController()
        currentNavigationController = vc
        window.rootViewController = vc
    }
    
    func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let item = ShortcutIdentifier(rawValue: shortcutItem.type) else {
            return false
        }
        
        var handled = false
        
        currentNavigationController?.dismissViewControllerAnimated(false, completion: nil)
        
        switch item {
        case .BestVenuesAroundMe:
            handled = true
            let vc = UIAlertController(title: "Just an experiment :)", message: nil, preferredStyle: .Alert)
            currentNavigationController?.presentViewController(vc, animated: true, completion: nil)
        }
        
        return handled
    }
}