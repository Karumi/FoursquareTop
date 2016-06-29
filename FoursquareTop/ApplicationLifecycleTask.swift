
import UIKit

protocol ApplicationLifecycleTask {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool?
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) -> Bool?
    
    func applicationDidEnterBackground(application: UIApplication)
    func applicationDidBecomeActive(application: UIApplication)
    func applicationWillTerminate(application: UIApplication)
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool?
    
    func executeOnBackground(block: () -> ())
}

extension ApplicationLifecycleTask {
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool? {
        return nil
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return false
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) { }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) { }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) -> Bool? {
        return nil
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool? {
        return nil
    }
    
    func applicationDidEnterBackground(application: UIApplication) { }
    func applicationDidBecomeActive(application: UIApplication) { }
    func applicationWillTerminate(application: UIApplication) { }
    
    func executeOnBackground(block: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            block()
        }
    }
    
}