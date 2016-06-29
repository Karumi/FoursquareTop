
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
        
//        self.serviceLocator.user.navigator = self
//        self.serviceLocator.appInitialization.navigator = self
//        self.serviceLocator.advert.navigator = self
//        self.serviceLocator.favorites.navigator = self
//        self.serviceLocator.help.navigator = self
    }
    
    convenience override init() {
        self.init(serviceLocator: RootServiceLocator.instance)
    }
    
    func installRootViewController(window: UIWindow) {
        let vc = serviceLocator.getInitialViewController()
        currentNavigationController = vc
        window.rootViewController = vc
    }
}