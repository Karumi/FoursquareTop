
import UIKit

enum ApplicationSections : Int {
    case List, Detail, Photos
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
}