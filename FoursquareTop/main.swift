
import Foundation
import UIKit

let appDelegateClass = Environment().isInTestingRun() ? NSStringFromClass(AppDelegateForTests) : NSStringFromClass(AppDelegate)

UIApplicationMain(
    Process.argc,
    Process.unsafeArgv,
    nil,
    appDelegateClass
)