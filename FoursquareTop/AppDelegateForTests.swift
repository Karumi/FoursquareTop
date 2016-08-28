import UIKit

class AppDelegateForTests: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {

        // Create a fake window to make UI tests work correctly
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = .whiteColor()
        window!.makeKeyAndVisible()
        window!.rootViewController = UINavigationController()
        return true
    }
}