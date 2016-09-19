
import Foundation
import UIKit

class ShortcutTask : ApplicationLifecycleTask {
    
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool? {
        var shouldPerformAdditionalDelegateHandling = true
        
        if let launchOptions = launchOptions, shortcutValue = launchOptions[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutValue
            shouldPerformAdditionalDelegateHandling = false
        }
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        guard let delegate = application.delegate as? AppDelegate else {
            return
        }
        
        if let launchedShortcutItem = launchedShortcutItem {
            delegate.navigator.handleShortcutItem(launchedShortcutItem)
            self.launchedShortcutItem = nil
        }
    }
}
