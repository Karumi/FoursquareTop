
import UIKit

class AppDelegate : NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigator: RootNavigator!
    private var tasks: [ApplicationLifecycleTask] = []
    
    // MARK: UIApplicationDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        tasks = FoursquareTopApplicationLifeCycleTasks.allTasks
        let initial: Bool? = nil
        let delegateResult = tasks.reduce(initial) { (result, task) in
            if let taksResult = task.application(application, didFinishLaunchingWithOptions: launchOptions) where result != nil {
                return taksResult
            }
            
            return nil
            
            } ?? true
        
        createWindow()
        installRootNavigator()
        
        return delegateResult
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        let initial: Bool = false
        return tasks.reduce(initial) { (result, task) in
            guard !result else {
                return result
            }
            
            return task.application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        }
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        tasks.forEach {
            $0.applicationDidEnterBackground(application)
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        tasks.forEach {
            $0.applicationDidBecomeActive(application)
        }
    }
    
    func applicationWillTerminate(application: UIApplication) {
        tasks.forEach {
            $0.applicationWillTerminate(application)
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        tasks.forEach {
            $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        tasks.forEach {
            $0.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        tasks.forEach {
            $0.application(application, didReceiveRemoteNotification: userInfo)
        }
    }
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
//        let shortcutItemHandled = navigator.handleShortcutItem(shortcutItem)
//        completionHandler(shortcutItemHandled)
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        let initial: Bool = false
        return tasks.reduce(initial) { (result, task) in
            guard !result else {
                return result
            }
            
            return task.application(application, continueUserActivity: userActivity, restorationHandler: restorationHandler) ?? false
        }
    }
    
    // MARK: Private
    private func createWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = .whiteColor()
    }
    
    private func installRootNavigator() {
        navigator = RootNavigator()
        navigator.installRootViewController(window!)
        window?.makeKeyAndVisible()
    }
}