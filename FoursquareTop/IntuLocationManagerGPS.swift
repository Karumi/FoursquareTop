
import Foundation
import INTULocationManager
import Result

typealias GPSAccuracy = INTULocationAccuracy

class IntuLocationManagerGPS : NSObject, GPS {
    
    func getUserPosition(withAccuracy accuracy: GPSAccuracy, timeout: NSTimeInterval, callback: Result<CLLocation, LocationError> -> ()) {
        
        let locationManager = INTULocationManager.sharedInstance()
        
        locationManager.requestLocationWithDesiredAccuracy(.Block, timeout: timeout, delayUntilAuthorized: true) { (location, accuracy, status) in
            
            switch status {
            case .Success:
                callback(Result(location))
                
            case .Error: fallthrough
            case .TimedOut:
                callback(Result(error: .CanNotFetch))
                
            case .ServicesNotDetermined: fallthrough
            case .ServicesDenied: fallthrough
            case .ServicesRestricted: fallthrough
            case .ServicesDisabled:
                callback(Result(error: .NoGPSAccess))
            }
        }
    }
}
