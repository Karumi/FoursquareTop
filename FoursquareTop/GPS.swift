
import Foundation
import Result
import MapKit

enum LocationError : ErrorType {
    case NoGPSAccess
    case CanNotFetch
}

protocol GPS {
    func getUserPosition(withAccuracy accuracy: GPSAccuracy, timeout: NSTimeInterval, callback: Result<CLLocation, LocationError> -> ())
}
