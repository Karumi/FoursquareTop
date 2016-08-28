
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
    let serviceLocator: RootServiceLocator
    
    init(serviceLocator: RootServiceLocator) {
        self.serviceLocator = serviceLocator
        
        super.init()
        
        serviceLocator.venue.navigator = self
    }
    
    func installRootViewController(window: UIWindow) {
        let vc = serviceLocator.getInitialViewController()
        currentNavigationController = vc
        window.rootViewController = vc
    }
}